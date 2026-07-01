class Ephemdir < Formula
  include Language::Python::Virtualenv

  desc "Temporary directories that clean themselves up after a lifetime or on restart"
  homepage "https://github.com/vindfjur/ephemdir"
  url "https://files.pythonhosted.org/packages/94/5a/50eb274820712028b51b5789583df82b7cb8f3c243ad593b3af6bfe78147/ephemdir-0.7.0.tar.gz"
  sha256 "77e8f9f73e408af0608f091b13d53798f3c77318f8bf80fd58583d0e15360c8e"
  license "Apache-2.0"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "0.7.0", shell_output("#{bin}/ephemdir --version")
    created = shell_output("#{bin}/ephemdir new --lifetime 1h").strip
    assert_predicate Pathname.new(created), :directory?
    name = Pathname.new(created).basename.to_s
    assert_equal created, shell_output("#{bin}/ephemdir path #{name}").strip
    assert_match created, shell_output("#{bin}/ephemdir keep #{name}")
  end
end