import importlib.util
import unittest
from pathlib import Path


SCRIPT = Path(__file__).parents[1] / "scripts" / "update_tov.py"
spec = importlib.util.spec_from_file_location("update_tov", SCRIPT)
update_tov = importlib.util.module_from_spec(spec)
spec.loader.exec_module(update_tov)


FORMULA = '''class Tov < Formula
  version "1.1.1"
  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/magcho/tmux-overview/releases/download/v1.1.1/tov_1.1.1_darwin_amd64.tar.gz"
      sha256 "old-darwin-amd64"
    end
    if Hardware::CPU.arm?
      url "https://github.com/magcho/tmux-overview/releases/download/v1.1.1/tov_1.1.1_darwin_arm64.tar.gz"
      sha256 "old-darwin-arm64"
    end
  end
  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/magcho/tmux-overview/releases/download/v1.1.1/tov_1.1.1_linux_amd64.tar.gz"
      sha256 "old-linux-amd64"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/magcho/tmux-overview/releases/download/v1.1.1/tov_1.1.1_linux_arm64.tar.gz"
      sha256 "old-linux-arm64"
    end
  end
end
'''


class UpdateFormulaTests(unittest.TestCase):
    def setUp(self):
        self.checksums = {
            "tov_1.2.1_darwin_amd64.tar.gz": "a" * 64,
            "tov_1.2.1_darwin_arm64.tar.gz": "b" * 64,
            "tov_1.2.1_linux_amd64.tar.gz": "c" * 64,
            "tov_1.2.1_linux_arm64.tar.gz": "d" * 64,
        }

    def test_updates_version_urls_and_checksums(self):
        result = update_tov.update_formula(FORMULA, "v1.2.1", self.checksums)

        self.assertIn('version "1.2.1"', result)
        for filename, checksum in self.checksums.items():
            self.assertIn(f"/v1.2.1/{filename}", result)
            self.assertIn(f'sha256 "{checksum}"', result)
        self.assertNotIn("v1.1.1", result)

    def test_is_idempotent(self):
        once = update_tov.update_formula(FORMULA, "v1.2.1", self.checksums)
        twice = update_tov.update_formula(once, "v1.2.1", self.checksums)
        self.assertEqual(once, twice)

    def test_preserves_blank_line_after_checksum(self):
        formula = FORMULA.replace(
            'sha256 "old-darwin-amd64"\n',
            'sha256 "old-darwin-amd64"\n\n',
        )
        result = update_tov.update_formula(formula, "v1.2.1", self.checksums)
        self.assertIn(f'sha256 "{"a" * 64}"\n\n', result)

    def test_rejects_release_with_missing_archive_checksum(self):
        del self.checksums["tov_1.2.1_linux_arm64.tar.gz"]
        with self.assertRaisesRegex(ValueError, "missing checksum"):
            update_tov.update_formula(FORMULA, "v1.2.1", self.checksums)

    def test_rejects_non_version_release_tag(self):
        with self.assertRaisesRegex(ValueError, "invalid release tag"):
            update_tov.update_formula(FORMULA, "latest", self.checksums)


if __name__ == "__main__":
    unittest.main()
