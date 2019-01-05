import unittest
import base

class Suite(base.Base):
    def test_1(self):
        """Test case 1"""
        self.start('Char/main')
        self.assertEqual("A!", self.body_text())
