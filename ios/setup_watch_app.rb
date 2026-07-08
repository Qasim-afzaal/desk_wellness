#!/usr/bin/env ruby
# Adds the Affirmly Watch App target to Runner.xcodeproj (run once from ios/).
# NOTE: Watch target is currently DISABLED for iOS Simulator builds.
# The watchapp2 product type breaks `flutter run` on iPhone Simulator unless
# you also add a Watch Extension + paired Watch simulator.
# To re-enable later, restore ios/Runner.xcodeproj from git and use Xcode's
# File > New > Target > Watch App wizard instead of this script.
#
# Usage: cd ios && ruby setup_watch_app.rb

require 'xcodeproj'

WATCH_NAME = 'Affirmly Watch App'
IOS_BUNDLE = 'com.intellig.deskwellness.deskWellness'
WATCH_BUNDLE = "#{IOS_BUNDLE}.watchkitapp"
WATCHOS_DEPLOYMENT = '10.0'
SWIFT_FILES = [
  'AffirmlyWatchApp.swift',
  'ContentView.swift',
  'WatchSessionManager.swift',
].freeze

project_path = File.join(__dir__, 'Runner.xcodeproj')
project = Xcodeproj::Project.open(project_path)

existing = project.targets.find { |t| t.name == WATCH_NAME }
if existing
  puts "✓ #{WATCH_NAME} target already exists"
  exit 0
end

watch_group = project.main_group.find_subpath(WATCH_NAME, true)
watch_group.set_source_tree('<group>')
watch_group.set_path(WATCH_NAME)

watch_target = project.new_target(:watch2_app, WATCH_NAME, :watchos, WATCHOS_DEPLOYMENT)
watch_target.product_name = WATCH_NAME

SWIFT_FILES.each do |file|
  ref = watch_group.new_file(file)
  watch_target.source_build_phase.add_file_reference(ref)
end

assets = watch_group.new_file('Assets.xcassets')
watch_target.resources_build_phase.add_file_reference(assets)

preview = watch_group.new_file('Preview Content/Preview Assets.xcassets')
watch_target.resources_build_phase.add_file_reference(preview)

ios_target = project.targets.find { |t| t.name == 'Runner' }
abort('Runner target not found') unless ios_target

embed = ios_target.copy_files_build_phases.find { |p| p.name == 'Embed Watch Content' }
unless embed
  embed = ios_target.new_copy_files_build_phase('Embed Watch Content')
  embed.dst_subfolder_spec = '16'
end

build_file = project.new(Xcodeproj::Project::Object::PBXBuildFile)
build_file.file_ref = watch_target.product_reference
embed.files << build_file

ios_target.add_dependency(watch_target)

ios_team = ios_target.build_configurations.first.build_settings['DEVELOPMENT_TEAM']

watch_target.build_configurations.each do |config|
  config.build_settings['INFOPLIST_KEY_CFBundleDisplayName'] = 'Affirmly'
  config.build_settings['INFOPLIST_KEY_WKCompanionAppBundleIdentifier'] = IOS_BUNDLE
  config.build_settings['PRODUCT_BUNDLE_IDENTIFIER'] = WATCH_BUNDLE
  config.build_settings['SWIFT_VERSION'] = '5.0'
  config.build_settings['TARGETED_DEVICE_FAMILY'] = '4'
  config.build_settings['WATCHOS_DEPLOYMENT_TARGET'] = WATCHOS_DEPLOYMENT
  config.build_settings['DEVELOPMENT_ASSET_PATHS'] = '"Affirmly Watch App/Preview Content"'
  config.build_settings['ENABLE_PREVIEWS'] = 'YES'
  config.build_settings['GENERATE_INFOPLIST_FILE'] = 'YES'
  config.build_settings['SKIP_INSTALL'] = 'YES'
  config.build_settings['DEVELOPMENT_TEAM'] = ios_team if ios_team
end

project.save
puts "✓ Added #{WATCH_NAME} target (#{WATCH_BUNDLE})"
puts "  Next: cd ios && pod install && open Runner.xcworkspace"
puts "  Build Runner scheme with a paired Apple Watch simulator or device"
