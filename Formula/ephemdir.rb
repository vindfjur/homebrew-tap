class Ephemdir < Formula
  include Language::Python::Virtualenv

  desc "Temporary directories that clean themselves up after a lifetime or on restart"
  homepage "https://github.com/vindfjur/ephemdir"
  url "https://files.pythonhosted.org/packages/94/33/4a9e1b67a8ca30e5e8c5317cf7aa66655eba8327c1857639362e2d2893c3/ephemdir-0.5.0.tar.gz"
  sha256 "78cc1b85d37e03b8f8a7cc9fb78d1034bdcc6d0ab322fc36106f197f00fe42f3"
  license "MIT"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "0.5.0", shell_output("#{bin}/ephemdir --version")
    created = shell_output("#{bin}/ephemdir new --lifetime 1h").strip
    assert_predicate Pathname.new(created), :directory?
    name = Pathname.new(created).basename.to_s
    assert_equal created, shell_output("#{bin}/ephemdir path #{name}").strip
    assert_match created, shell_output("#{bin}/ephemdir keep #{name}")
  end
end