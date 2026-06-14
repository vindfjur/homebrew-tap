class Ephemdir < Formula
  include Language::Python::Virtualenv

  desc "Temporary directories that clean themselves up after a lifetime or on restart"
  homepage "https://github.com/vindfjur/ephemdir"
  url "https://files.pythonhosted.org/packages/0d/65/b391ff345d6e931c7dd48264d18858cda73e78f3d2279f70da961f1180eb/ephemdir-0.4.0.tar.gz"
  sha256 "16af129720bfe017c501a0718963b974ee071dbcea02fcc0bf69c8600d145b16"
  license "MIT"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "0.4.0", shell_output("#{bin}/ephemdir --version")
    created = shell_output("#{bin}/ephemdir new --lifetime 1h").strip
    assert_predicate Pathname.new(created), :directory?
    name = Pathname.new(created).basename.to_s
    assert_equal created, shell_output("#{bin}/ephemdir path #{name}").strip
    assert_match created, shell_output("#{bin}/ephemdir keep #{name}")
  end
end
