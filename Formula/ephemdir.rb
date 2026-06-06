class Ephemdir < Formula
  include Language::Python::Virtualenv

  desc "Temporary directories that clean themselves up after a lifetime or on restart"
  homepage "https://github.com/vindfjur/ephemdir"
  url "https://files.pythonhosted.org/packages/fc/62/ac45b5ea40dcfd62734929e7f03753179f44d248bb1ac79b9ebd42bdaeae/ephemdir-0.2.0.tar.gz"
  sha256 "2f9246871bc72abadc5882339de4794e8ac67379fda498939f32bfd7e3f49342"
  license "MIT"

  depends_on "python@3.12"

  resource "coolname" do
    url "https://files.pythonhosted.org/packages/fe/45/deae12f31934301a488df985880240a200119aca2e4b5ceba71d73bc5e86/coolname-5.0.0.tar.gz"
    sha256 "594bc6c98ebc75ddd51c0ce10efbb5d2556c14eac60b5b36900dfdd5db20eecf"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "0.2.0", shell_output("#{bin}/ephemdir --version")
    created = shell_output("#{bin}/ephemdir new --lifetime 1h").strip
    assert_predicate Pathname.new(created), :directory?
  end
end
