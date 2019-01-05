import unittest
import base

class Suite(base.Base):
    def test_1(self):
        """Test case 1"""
        self.start('Consub/main')
        self.assertEqual("1 2\n3 5", self.body_text())
    def test_2(self):
        """Test case 1"""
        self.start('Consub/fails')
        self.assertRegex(self.body_text(), "^Fatal error: .*$")
