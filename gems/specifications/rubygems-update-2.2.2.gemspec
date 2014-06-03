# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rubygems-update}
  s.version = "2.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jim Weirich", "Chad Fowler", "Eric Hodel"]
  s.cert_chain = ["-----BEGIN CERTIFICATE-----\nMIIDeDCCAmCgAwIBAgIBATANBgkqhkiG9w0BAQUFADBBMRAwDgYDVQQDDAdkcmJy\nYWluMRgwFgYKCZImiZPyLGQBGRYIc2VnbWVudDcxEzARBgoJkiaJk/IsZAEZFgNu\nZXQwHhcNMTMwMjI4MDUyMjA4WhcNMTQwMjI4MDUyMjA4WjBBMRAwDgYDVQQDDAdk\ncmJyYWluMRgwFgYKCZImiZPyLGQBGRYIc2VnbWVudDcxEzARBgoJkiaJk/IsZAEZ\nFgNuZXQwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCbbgLrGLGIDE76\nLV/cvxdEzCuYuS3oG9PrSZnuDweySUfdp/so0cDq+j8bqy6OzZSw07gdjwFMSd6J\nU5ddZCVywn5nnAQ+Ui7jMW54CYt5/H6f2US6U0hQOjJR6cpfiymgxGdfyTiVcvTm\nGj/okWrQl0NjYOYBpDi+9PPmaH2RmLJu0dB/NylsDnW5j6yN1BEI8MfJRR+HRKZY\nmUtgzBwF1V4KIZQ8EuL6I/nHVu07i6IkrpAgxpXUfdJQJi0oZAqXurAV3yTxkFwd\ng62YrrW26mDe+pZBzR6bpLE+PmXCzz7UxUq3AE0gPHbiMXie3EFE0oxnsU3lIduh\nsCANiQ8BAgMBAAGjezB5MAkGA1UdEwQCMAAwCwYDVR0PBAQDAgSwMB0GA1UdDgQW\nBBS5k4Z75VSpdM0AclG2UvzFA/VW5DAfBgNVHREEGDAWgRRkcmJyYWluQHNlZ21l\nbnQ3Lm5ldDAfBgNVHRIEGDAWgRRkcmJyYWluQHNlZ21lbnQ3Lm5ldDANBgkqhkiG\n9w0BAQUFAAOCAQEAOflo4Md5aJF//EetzXIGZ2EI5PzKWX/mMpp7cxFyDcVPtTv0\njs/6zWrWSbd60W9Kn4ch3nYiATFKhisgeYotDDz2/pb/x1ivJn4vEvs9kYKVvbF8\nV7MV/O5HDW8Q0pA1SljI6GzcOgejtUMxZCyyyDdbUpyAMdt9UpqTZkZ5z1sicgQk\n5o2XJ+OhceOIUVqVh1r6DNY5tLVaGJabtBmJAYFVznDcHiSFybGKBa5n25Egql1t\nKDyY1VIazVgoC8XvR4h/95/iScPiuglzA+DBG1hip1xScAtw05BrXyUNrc9CEMYU\nwgF94UVoHRp6ywo8I7NP3HcwFQDFNEZPNGXsng==\n-----END CERTIFICATE-----\n"]
  s.date = %q{2014-02-05}
  s.default_executable = %q{update_rubygems}
  s.description = %q{RubyGems is a package management framework for Ruby.

This gem is an update for the RubyGems software. You must have an
installation of RubyGems before this update can be applied.

See Gem for information on RubyGems (or `ri Gem`)

To upgrade to the latest RubyGems, run:

  $ gem update --system  # you might need to be an administrator or root

See UPGRADING.rdoc for more details and alternative instructions.

-----

If you don't have RubyGems installed, you can still do it manually:

* Download from: https://rubygems.org/pages/download
* Unpack into a directory and cd there
* Install with: ruby setup.rb  # you may need admin/root privilege

For more details and other options, see:

  ruby setup.rb --help}
  s.email = ["rubygems-developers@rubyforge.org"]
  s.executables = ["update_rubygems"]
  s.extra_rdoc_files = ["CVE-2013-4287.txt", "CVE-2013-4363.txt", "History.txt", "LICENSE.txt", "MIT.txt", "Manifest.txt", "README.rdoc", "UPGRADING.rdoc", "hide_lib_for_update/note.txt"]
  s.files = [".autotest", ".document", ".gemtest", "CVE-2013-4287.txt", "CVE-2013-4363.txt", "History.txt", "LICENSE.txt", "MIT.txt", "Manifest.txt", "README.rdoc", "Rakefile", "UPGRADING.rdoc", "bin/gem", "bin/update_rubygems", "hide_lib_for_update/note.txt", "lib/gauntlet_rubygems.rb", "lib/rubygems.rb", "lib/rubygems/available_set.rb", "lib/rubygems/basic_specification.rb", "lib/rubygems/command.rb", "lib/rubygems/command_manager.rb", "lib/rubygems/commands/build_command.rb", "lib/rubygems/commands/cert_command.rb", "lib/rubygems/commands/check_command.rb", "lib/rubygems/commands/cleanup_command.rb", "lib/rubygems/commands/contents_command.rb", "lib/rubygems/commands/dependency_command.rb", "lib/rubygems/commands/environment_command.rb", "lib/rubygems/commands/fetch_command.rb", "lib/rubygems/commands/generate_index_command.rb", "lib/rubygems/commands/help_command.rb", "lib/rubygems/commands/install_command.rb", "lib/rubygems/commands/list_command.rb", "lib/rubygems/commands/lock_command.rb", "lib/rubygems/commands/mirror_command.rb", "lib/rubygems/commands/outdated_command.rb", "lib/rubygems/commands/owner_command.rb", "lib/rubygems/commands/pristine_command.rb", "lib/rubygems/commands/push_command.rb", "lib/rubygems/commands/query_command.rb", "lib/rubygems/commands/rdoc_command.rb", "lib/rubygems/commands/search_command.rb", "lib/rubygems/commands/server_command.rb", "lib/rubygems/commands/setup_command.rb", "lib/rubygems/commands/sources_command.rb", "lib/rubygems/commands/specification_command.rb", "lib/rubygems/commands/stale_command.rb", "lib/rubygems/commands/uninstall_command.rb", "lib/rubygems/commands/unpack_command.rb", "lib/rubygems/commands/update_command.rb", "lib/rubygems/commands/which_command.rb", "lib/rubygems/commands/yank_command.rb", "lib/rubygems/compatibility.rb", "lib/rubygems/config_file.rb", "lib/rubygems/core_ext/kernel_gem.rb", "lib/rubygems/core_ext/kernel_require.rb", "lib/rubygems/defaults.rb", "lib/rubygems/dependency.rb", "lib/rubygems/dependency_installer.rb", "lib/rubygems/dependency_list.rb", "lib/rubygems/deprecate.rb", "lib/rubygems/doctor.rb", "lib/rubygems/errors.rb", "lib/rubygems/exceptions.rb", "lib/rubygems/ext.rb", "lib/rubygems/ext/build_error.rb", "lib/rubygems/ext/builder.rb", "lib/rubygems/ext/cmake_builder.rb", "lib/rubygems/ext/configure_builder.rb", "lib/rubygems/ext/ext_conf_builder.rb", "lib/rubygems/ext/rake_builder.rb", "lib/rubygems/gem_runner.rb", "lib/rubygems/gemcutter_utilities.rb", "lib/rubygems/indexer.rb", "lib/rubygems/install_default_message.rb", "lib/rubygems/install_message.rb", "lib/rubygems/install_update_options.rb", "lib/rubygems/installer.rb", "lib/rubygems/installer_test_case.rb", "lib/rubygems/local_remote_options.rb", "lib/rubygems/mock_gem_ui.rb", "lib/rubygems/name_tuple.rb", "lib/rubygems/package.rb", "lib/rubygems/package/digest_io.rb", "lib/rubygems/package/old.rb", "lib/rubygems/package/tar_header.rb", "lib/rubygems/package/tar_reader.rb", "lib/rubygems/package/tar_reader/entry.rb", "lib/rubygems/package/tar_test_case.rb", "lib/rubygems/package/tar_writer.rb", "lib/rubygems/package_task.rb", "lib/rubygems/path_support.rb", "lib/rubygems/platform.rb", "lib/rubygems/psych_additions.rb", "lib/rubygems/psych_tree.rb", "lib/rubygems/rdoc.rb", "lib/rubygems/remote_fetcher.rb", "lib/rubygems/request.rb", "lib/rubygems/request_set.rb", "lib/rubygems/request_set/gem_dependency_api.rb", "lib/rubygems/request_set/lockfile.rb", "lib/rubygems/requirement.rb", "lib/rubygems/resolver.rb", "lib/rubygems/resolver/activation_request.rb", "lib/rubygems/resolver/api_set.rb", "lib/rubygems/resolver/api_specification.rb", "lib/rubygems/resolver/best_set.rb", "lib/rubygems/resolver/composed_set.rb", "lib/rubygems/resolver/conflict.rb", "lib/rubygems/resolver/current_set.rb", "lib/rubygems/resolver/dependency_request.rb", "lib/rubygems/resolver/git_set.rb", "lib/rubygems/resolver/git_specification.rb", "lib/rubygems/resolver/index_set.rb", "lib/rubygems/resolver/index_specification.rb", "lib/rubygems/resolver/installed_specification.rb", "lib/rubygems/resolver/installer_set.rb", "lib/rubygems/resolver/local_specification.rb", "lib/rubygems/resolver/lock_set.rb", "lib/rubygems/resolver/lock_specification.rb", "lib/rubygems/resolver/requirement_list.rb", "lib/rubygems/resolver/set.rb", "lib/rubygems/resolver/spec_specification.rb", "lib/rubygems/resolver/specification.rb", "lib/rubygems/resolver/stats.rb", "lib/rubygems/resolver/vendor_set.rb", "lib/rubygems/resolver/vendor_specification.rb", "lib/rubygems/security.rb", "lib/rubygems/security/policies.rb", "lib/rubygems/security/policy.rb", "lib/rubygems/security/signer.rb", "lib/rubygems/security/trust_dir.rb", "lib/rubygems/server.rb", "lib/rubygems/source.rb", "lib/rubygems/source/git.rb", "lib/rubygems/source/installed.rb", "lib/rubygems/source/local.rb", "lib/rubygems/source/lock.rb", "lib/rubygems/source/specific_file.rb", "lib/rubygems/source/vendor.rb", "lib/rubygems/source_list.rb", "lib/rubygems/source_local.rb", "lib/rubygems/source_specific_file.rb", "lib/rubygems/spec_fetcher.rb", "lib/rubygems/specification.rb", "lib/rubygems/ssl_certs/.document", "lib/rubygems/ssl_certs/Class3PublicPrimaryCertificationAuthority.pem", "lib/rubygems/ssl_certs/DigiCertHighAssuranceEVRootCA.pem", "lib/rubygems/ssl_certs/EntrustnetSecureServerCertificationAuthority.pem", "lib/rubygems/ssl_certs/GeoTrustGlobalCA.pem", "lib/rubygems/stub_specification.rb", "lib/rubygems/syck_hack.rb", "lib/rubygems/test_case.rb", "lib/rubygems/test_utilities.rb", "lib/rubygems/text.rb", "lib/rubygems/uninstaller.rb", "lib/rubygems/uri_formatter.rb", "lib/rubygems/user_interaction.rb", "lib/rubygems/util.rb", "lib/rubygems/util/list.rb", "lib/rubygems/util/stringio.rb", "lib/rubygems/validator.rb", "lib/rubygems/version.rb", "lib/rubygems/version_option.rb", "lib/ubygems.rb", "setup.rb", "test/rubygems/alternate_cert.pem", "test/rubygems/alternate_cert_32.pem", "test/rubygems/alternate_key.pem", "test/rubygems/bad_rake.rb", "test/rubygems/bogussources.rb", "test/rubygems/ca_cert.pem", "test/rubygems/child_cert.pem", "test/rubygems/child_cert_32.pem", "test/rubygems/child_key.pem", "test/rubygems/client.pem", "test/rubygems/data/gem-private_key.pem", "test/rubygems/data/gem-public_cert.pem", "test/rubygems/data/null-type.gemspec.rz", "test/rubygems/encrypted_private_key.pem", "test/rubygems/expired_cert.pem", "test/rubygems/fake_certlib/openssl.rb", "test/rubygems/fix_openssl_warnings.rb", "test/rubygems/foo/discover.rb", "test/rubygems/future_cert.pem", "test/rubygems/future_cert_32.pem", "test/rubygems/good_rake.rb", "test/rubygems/grandchild_cert.pem", "test/rubygems/grandchild_cert_32.pem", "test/rubygems/grandchild_key.pem", "test/rubygems/invalid_client.pem", "test/rubygems/invalid_issuer_cert.pem", "test/rubygems/invalid_issuer_cert_32.pem", "test/rubygems/invalid_key.pem", "test/rubygems/invalid_signer_cert.pem", "test/rubygems/invalid_signer_cert_32.pem", "test/rubygems/invalidchild_cert.pem", "test/rubygems/invalidchild_cert_32.pem", "test/rubygems/invalidchild_key.pem", "test/rubygems/plugin/exception/rubygems_plugin.rb", "test/rubygems/plugin/load/rubygems_plugin.rb", "test/rubygems/plugin/standarderror/rubygems_plugin.rb", "test/rubygems/private_key.pem", "test/rubygems/public_cert.pem", "test/rubygems/public_cert_32.pem", "test/rubygems/public_key.pem", "test/rubygems/rubygems/commands/crash_command.rb", "test/rubygems/rubygems_plugin.rb", "test/rubygems/sff/discover.rb", "test/rubygems/simple_gem.rb", "test/rubygems/specifications/bar-0.0.2.gemspec", "test/rubygems/specifications/foo-0.0.1.gemspec", "test/rubygems/ssl_cert.pem", "test/rubygems/ssl_key.pem", "test/rubygems/test_bundled_ca.rb", "test/rubygems/test_config.rb", "test/rubygems/test_deprecate.rb", "test/rubygems/test_gem.rb", "test/rubygems/test_gem_available_set.rb", "test/rubygems/test_gem_command.rb", "test/rubygems/test_gem_command_manager.rb", "test/rubygems/test_gem_commands_build_command.rb", "test/rubygems/test_gem_commands_cert_command.rb", "test/rubygems/test_gem_commands_check_command.rb", "test/rubygems/test_gem_commands_cleanup_command.rb", "test/rubygems/test_gem_commands_contents_command.rb", "test/rubygems/test_gem_commands_dependency_command.rb", "test/rubygems/test_gem_commands_environment_command.rb", "test/rubygems/test_gem_commands_fetch_command.rb", "test/rubygems/test_gem_commands_generate_index_command.rb", "test/rubygems/test_gem_commands_help_command.rb", "test/rubygems/test_gem_commands_install_command.rb", "test/rubygems/test_gem_commands_list_command.rb", "test/rubygems/test_gem_commands_lock_command.rb", "test/rubygems/test_gem_commands_mirror.rb", "test/rubygems/test_gem_commands_outdated_command.rb", "test/rubygems/test_gem_commands_owner_command.rb", "test/rubygems/test_gem_commands_pristine_command.rb", "test/rubygems/test_gem_commands_push_command.rb", "test/rubygems/test_gem_commands_query_command.rb", "test/rubygems/test_gem_commands_search_command.rb", "test/rubygems/test_gem_commands_server_command.rb", "test/rubygems/test_gem_commands_setup_command.rb", "test/rubygems/test_gem_commands_sources_command.rb", "test/rubygems/test_gem_commands_specification_command.rb", "test/rubygems/test_gem_commands_stale_command.rb", "test/rubygems/test_gem_commands_uninstall_command.rb", "test/rubygems/test_gem_commands_unpack_command.rb", "test/rubygems/test_gem_commands_update_command.rb", "test/rubygems/test_gem_commands_which_command.rb", "test/rubygems/test_gem_commands_yank_command.rb", "test/rubygems/test_gem_config_file.rb", "test/rubygems/test_gem_dependency.rb", "test/rubygems/test_gem_dependency_installer.rb", "test/rubygems/test_gem_dependency_list.rb", "test/rubygems/test_gem_dependency_resolution_error.rb", "test/rubygems/test_gem_doctor.rb", "test/rubygems/test_gem_ext_builder.rb", "test/rubygems/test_gem_ext_cmake_builder.rb", "test/rubygems/test_gem_ext_configure_builder.rb", "test/rubygems/test_gem_ext_ext_conf_builder.rb", "test/rubygems/test_gem_ext_rake_builder.rb", "test/rubygems/test_gem_gem_runner.rb", "test/rubygems/test_gem_gemcutter_utilities.rb", "test/rubygems/test_gem_impossible_dependencies_error.rb", "test/rubygems/test_gem_indexer.rb", "test/rubygems/test_gem_install_update_options.rb", "test/rubygems/test_gem_installer.rb", "test/rubygems/test_gem_local_remote_options.rb", "test/rubygems/test_gem_name_tuple.rb", "test/rubygems/test_gem_package.rb", "test/rubygems/test_gem_package_old.rb", "test/rubygems/test_gem_package_tar_header.rb", "test/rubygems/test_gem_package_tar_reader.rb", "test/rubygems/test_gem_package_tar_reader_entry.rb", "test/rubygems/test_gem_package_tar_writer.rb", "test/rubygems/test_gem_package_task.rb", "test/rubygems/test_gem_path_support.rb", "test/rubygems/test_gem_platform.rb", "test/rubygems/test_gem_rdoc.rb", "test/rubygems/test_gem_remote_fetcher.rb", "test/rubygems/test_gem_request.rb", "test/rubygems/test_gem_request_set.rb", "test/rubygems/test_gem_request_set_gem_dependency_api.rb", "test/rubygems/test_gem_request_set_lockfile.rb", "test/rubygems/test_gem_requirement.rb", "test/rubygems/test_gem_resolver.rb", "test/rubygems/test_gem_resolver_activation_request.rb", "test/rubygems/test_gem_resolver_api_set.rb", "test/rubygems/test_gem_resolver_api_specification.rb", "test/rubygems/test_gem_resolver_best_set.rb", "test/rubygems/test_gem_resolver_composed_set.rb", "test/rubygems/test_gem_resolver_conflict.rb", "test/rubygems/test_gem_resolver_dependency_request.rb", "test/rubygems/test_gem_resolver_git_set.rb", "test/rubygems/test_gem_resolver_git_specification.rb", "test/rubygems/test_gem_resolver_index_set.rb", "test/rubygems/test_gem_resolver_index_specification.rb", "test/rubygems/test_gem_resolver_installed_specification.rb", "test/rubygems/test_gem_resolver_installer_set.rb", "test/rubygems/test_gem_resolver_local_specification.rb", "test/rubygems/test_gem_resolver_lock_set.rb", "test/rubygems/test_gem_resolver_lock_specification.rb", "test/rubygems/test_gem_resolver_requirement_list.rb", "test/rubygems/test_gem_resolver_specification.rb", "test/rubygems/test_gem_resolver_vendor_set.rb", "test/rubygems/test_gem_resolver_vendor_specification.rb", "test/rubygems/test_gem_security.rb", "test/rubygems/test_gem_security_policy.rb", "test/rubygems/test_gem_security_signer.rb", "test/rubygems/test_gem_security_trust_dir.rb", "test/rubygems/test_gem_server.rb", "test/rubygems/test_gem_silent_ui.rb", "test/rubygems/test_gem_source.rb", "test/rubygems/test_gem_source_fetch_problem.rb", "test/rubygems/test_gem_source_git.rb", "test/rubygems/test_gem_source_installed.rb", "test/rubygems/test_gem_source_list.rb", "test/rubygems/test_gem_source_local.rb", "test/rubygems/test_gem_source_lock.rb", "test/rubygems/test_gem_source_specific_file.rb", "test/rubygems/test_gem_source_vendor.rb", "test/rubygems/test_gem_spec_fetcher.rb", "test/rubygems/test_gem_specification.rb", "test/rubygems/test_gem_stream_ui.rb", "test/rubygems/test_gem_stub_specification.rb", "test/rubygems/test_gem_text.rb", "test/rubygems/test_gem_uninstaller.rb", "test/rubygems/test_gem_uri_formatter.rb", "test/rubygems/test_gem_util.rb", "test/rubygems/test_gem_validator.rb", "test/rubygems/test_gem_version.rb", "test/rubygems/test_gem_version_option.rb", "test/rubygems/test_kernel.rb", "test/rubygems/test_require.rb", "test/rubygems/wrong_key_cert.pem", "test/rubygems/wrong_key_cert_32.pem", "util/CL2notes", "util/create_certs.rb", "util/create_encrypted_key.rb", "util/update_bundled_ca_certificates.rb"]
  s.homepage = %q{http://rubygems.org}
  s.licenses = ["Ruby", "MIT"]
  s.rdoc_options = ["--main", "README.rdoc", "--title=RubyGems Update Documentation"]
  s.require_paths = ["hide_lib_for_update"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")
  s.rubyforge_project = %q{rubygems-update}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{RubyGems is a package management framework for Ruby}
  s.test_files = ["test/rubygems/test_bundled_ca.rb", "test/rubygems/test_config.rb", "test/rubygems/test_deprecate.rb", "test/rubygems/test_gem.rb", "test/rubygems/test_gem_available_set.rb", "test/rubygems/test_gem_command.rb", "test/rubygems/test_gem_command_manager.rb", "test/rubygems/test_gem_commands_build_command.rb", "test/rubygems/test_gem_commands_cert_command.rb", "test/rubygems/test_gem_commands_check_command.rb", "test/rubygems/test_gem_commands_cleanup_command.rb", "test/rubygems/test_gem_commands_contents_command.rb", "test/rubygems/test_gem_commands_dependency_command.rb", "test/rubygems/test_gem_commands_environment_command.rb", "test/rubygems/test_gem_commands_fetch_command.rb", "test/rubygems/test_gem_commands_generate_index_command.rb", "test/rubygems/test_gem_commands_help_command.rb", "test/rubygems/test_gem_commands_install_command.rb", "test/rubygems/test_gem_commands_list_command.rb", "test/rubygems/test_gem_commands_lock_command.rb", "test/rubygems/test_gem_commands_mirror.rb", "test/rubygems/test_gem_commands_outdated_command.rb", "test/rubygems/test_gem_commands_owner_command.rb", "test/rubygems/test_gem_commands_pristine_command.rb", "test/rubygems/test_gem_commands_push_command.rb", "test/rubygems/test_gem_commands_query_command.rb", "test/rubygems/test_gem_commands_search_command.rb", "test/rubygems/test_gem_commands_server_command.rb", "test/rubygems/test_gem_commands_setup_command.rb", "test/rubygems/test_gem_commands_sources_command.rb", "test/rubygems/test_gem_commands_specification_command.rb", "test/rubygems/test_gem_commands_stale_command.rb", "test/rubygems/test_gem_commands_uninstall_command.rb", "test/rubygems/test_gem_commands_unpack_command.rb", "test/rubygems/test_gem_commands_update_command.rb", "test/rubygems/test_gem_commands_which_command.rb", "test/rubygems/test_gem_commands_yank_command.rb", "test/rubygems/test_gem_config_file.rb", "test/rubygems/test_gem_dependency.rb", "test/rubygems/test_gem_dependency_installer.rb", "test/rubygems/test_gem_dependency_list.rb", "test/rubygems/test_gem_dependency_resolution_error.rb", "test/rubygems/test_gem_doctor.rb", "test/rubygems/test_gem_ext_builder.rb", "test/rubygems/test_gem_ext_cmake_builder.rb", "test/rubygems/test_gem_ext_configure_builder.rb", "test/rubygems/test_gem_ext_ext_conf_builder.rb", "test/rubygems/test_gem_ext_rake_builder.rb", "test/rubygems/test_gem_gem_runner.rb", "test/rubygems/test_gem_gemcutter_utilities.rb", "test/rubygems/test_gem_impossible_dependencies_error.rb", "test/rubygems/test_gem_indexer.rb", "test/rubygems/test_gem_install_update_options.rb", "test/rubygems/test_gem_installer.rb", "test/rubygems/test_gem_local_remote_options.rb", "test/rubygems/test_gem_name_tuple.rb", "test/rubygems/test_gem_package.rb", "test/rubygems/test_gem_package_old.rb", "test/rubygems/test_gem_package_tar_header.rb", "test/rubygems/test_gem_package_tar_reader.rb", "test/rubygems/test_gem_package_tar_reader_entry.rb", "test/rubygems/test_gem_package_tar_writer.rb", "test/rubygems/test_gem_package_task.rb", "test/rubygems/test_gem_path_support.rb", "test/rubygems/test_gem_platform.rb", "test/rubygems/test_gem_rdoc.rb", "test/rubygems/test_gem_remote_fetcher.rb", "test/rubygems/test_gem_request.rb", "test/rubygems/test_gem_request_set.rb", "test/rubygems/test_gem_request_set_gem_dependency_api.rb", "test/rubygems/test_gem_request_set_lockfile.rb", "test/rubygems/test_gem_requirement.rb", "test/rubygems/test_gem_resolver.rb", "test/rubygems/test_gem_resolver_activation_request.rb", "test/rubygems/test_gem_resolver_api_set.rb", "test/rubygems/test_gem_resolver_api_specification.rb", "test/rubygems/test_gem_resolver_best_set.rb", "test/rubygems/test_gem_resolver_composed_set.rb", "test/rubygems/test_gem_resolver_conflict.rb", "test/rubygems/test_gem_resolver_dependency_request.rb", "test/rubygems/test_gem_resolver_git_set.rb", "test/rubygems/test_gem_resolver_git_specification.rb", "test/rubygems/test_gem_resolver_index_set.rb", "test/rubygems/test_gem_resolver_index_specification.rb", "test/rubygems/test_gem_resolver_installed_specification.rb", "test/rubygems/test_gem_resolver_installer_set.rb", "test/rubygems/test_gem_resolver_local_specification.rb", "test/rubygems/test_gem_resolver_lock_set.rb", "test/rubygems/test_gem_resolver_lock_specification.rb", "test/rubygems/test_gem_resolver_requirement_list.rb", "test/rubygems/test_gem_resolver_specification.rb", "test/rubygems/test_gem_resolver_vendor_set.rb", "test/rubygems/test_gem_resolver_vendor_specification.rb", "test/rubygems/test_gem_security.rb", "test/rubygems/test_gem_security_policy.rb", "test/rubygems/test_gem_security_signer.rb", "test/rubygems/test_gem_security_trust_dir.rb", "test/rubygems/test_gem_server.rb", "test/rubygems/test_gem_silent_ui.rb", "test/rubygems/test_gem_source.rb", "test/rubygems/test_gem_source_fetch_problem.rb", "test/rubygems/test_gem_source_git.rb", "test/rubygems/test_gem_source_installed.rb", "test/rubygems/test_gem_source_list.rb", "test/rubygems/test_gem_source_local.rb", "test/rubygems/test_gem_source_lock.rb", "test/rubygems/test_gem_source_specific_file.rb", "test/rubygems/test_gem_source_vendor.rb", "test/rubygems/test_gem_spec_fetcher.rb", "test/rubygems/test_gem_specification.rb", "test/rubygems/test_gem_stream_ui.rb", "test/rubygems/test_gem_stub_specification.rb", "test/rubygems/test_gem_text.rb", "test/rubygems/test_gem_uninstaller.rb", "test/rubygems/test_gem_uri_formatter.rb", "test/rubygems/test_gem_util.rb", "test/rubygems/test_gem_validator.rb", "test/rubygems/test_gem_version.rb", "test/rubygems/test_gem_version_option.rb", "test/rubygems/test_kernel.rb", "test/rubygems/test_require.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<minitest>, ["~> 5.2"])
      s.add_development_dependency(%q<rdoc>, ["~> 4.0"])
      s.add_development_dependency(%q<builder>, ["~> 2.1"])
      s.add_development_dependency(%q<hoe-seattlerb>, ["~> 1.2"])
      s.add_development_dependency(%q<ZenTest>, ["~> 4.5"])
      s.add_development_dependency(%q<rake>, ["~> 0.9.3"])
      s.add_development_dependency(%q<hoe>, ["~> 3.7"])
    else
      s.add_dependency(%q<minitest>, ["~> 5.2"])
      s.add_dependency(%q<rdoc>, ["~> 4.0"])
      s.add_dependency(%q<builder>, ["~> 2.1"])
      s.add_dependency(%q<hoe-seattlerb>, ["~> 1.2"])
      s.add_dependency(%q<ZenTest>, ["~> 4.5"])
      s.add_dependency(%q<rake>, ["~> 0.9.3"])
      s.add_dependency(%q<hoe>, ["~> 3.7"])
    end
  else
    s.add_dependency(%q<minitest>, ["~> 5.2"])
    s.add_dependency(%q<rdoc>, ["~> 4.0"])
    s.add_dependency(%q<builder>, ["~> 2.1"])
    s.add_dependency(%q<hoe-seattlerb>, ["~> 1.2"])
    s.add_dependency(%q<ZenTest>, ["~> 4.5"])
    s.add_dependency(%q<rake>, ["~> 0.9.3"])
    s.add_dependency(%q<hoe>, ["~> 3.7"])
  end
end
