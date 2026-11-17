class PiAgent < Formula
  desc "Self-hosted local AI workspace"
  homepage "https://github.com/qschen86/pi-agent"
  url "https://github.com/qschen86/pi-agent/releases/download/v0.1.2/pi-agent-0.1.2-macos-arm64.tar.gz"
  version "0.1.2"
  sha256 "3e41edd836da4b434506ab1fe7d0d49d2e94c1e95ef75f394dd1b332ec14e77a"
  license "MIT"

  depends_on arch: :arm64
  depends_on macos: :sequoia
  depends_on "node@24"

  def install
    libexec.install Dir["*"]
    inreplace libexec/"bin/node", "@HOMEBREW_NODE@", Formula["node@24"].opt_bin/"node"
    (bin/"pi-agent").write <<~SH
      #!/bin/sh
      exec "#{Formula["node@24"].opt_bin}/node" "#{opt_libexec}/main.mjs" "$@"
    SH
    chmod 0755, bin/"pi-agent"
  end

  service do
    run [opt_bin/"pi-agent", "serve"]
    keep_alive true
    process_type :background
    working_dir Dir.home
    log_path var/"log/pi-agent.log"
    error_log_path var/"log/pi-agent.log"
  end

  def caveats
    <<~EOS
      Start: brew services start pi-agent
      Open:  pi-agent open
      Data:  ~/Library/Application Support/pi-agent/instance/
      Uninstall preserves your private instance. Do not run the service with sudo.
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/pi-agent --version").strip
    assert_match '"state":"stopped"', shell_output("#{bin}/pi-agent status --json --data-parent '#{testpath}/empty'")
  end
end
