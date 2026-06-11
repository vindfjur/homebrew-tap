class Ephemdir < Formula
  include Language::Python::Virtualenv

  desc "Temporary directories that clean themselves up after a lifetime or on restart"
  homepage "https://github.com/vindfjur/ephemdir"
  url "https://files.pythonhosted.org/packages/f1/60/f64ae2e3404113e61721894e6ea0eb4385d282287cf054e371853b6a2ec1/ephemdir-0.3.0.tar.gz"
  sha256 "bf15f469b7c904e2afc3ca5190c813e48a60840d2660721cf1dd8af2d408ee96"
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
    assert_match "0.3.0", shell_output("#{bin}/ephemdir --version")
    created = shell_output("#{bin}/ephemdir new --lifetime 1h").strip
    assert_predicate Pathname.new(created), :directory?
    # 0.3.0: resolve the directory by name, then stop tracking it.
    name = Pathname.new(created).basename.to_s
    assert_equal created, shell_output("#{bin}/ephemdir path #{name}").strip
    assert_match created, shell_output("#{bin}/ephemdir keep #{name}")
  end
end
