import unittest
import base

class Suite(base.Base):
    def test_1(self):
        """Test case 1"""
        self.start('Cst/main')
        self.assertEqual("", self.body_text())
