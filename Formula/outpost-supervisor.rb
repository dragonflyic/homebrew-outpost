class OutpostSupervisor < Formula
  include Language::Python::Virtualenv

  desc "Operator-side brew reconciler (Dragonfly outpost)"
  homepage "https://github.com/dragonflyic/outpost"
  url "https://github.com/dragonflyic/outpost/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  license "Proprietary"
  version "0.1.0"

  depends_on "python@3.12"

  # `brew update-python-resources Formula/outpost-supervisor.rb` will
  # populate `resource "..."` blocks for transitive deps. After the first
  # successful manual install, run that and commit the result.

  def install
    virtualenv_install_with_resources
  end

  service do
    run [opt_bin/"outpost-supervisor", "daemon"]
    keep_alive true
    log_path var/"log/outpost-supervisor.log"
    error_log_path var/"log/outpost-supervisor.log"
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match "Usage", shell_output("#{bin}/outpost-supervisor --help")
  end
end
