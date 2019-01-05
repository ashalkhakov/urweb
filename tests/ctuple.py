import unittest
import base

class Suite(base.Base):
    def test_1(self):
        """Test case 1"""
        self.start('main')
        l = self.xpath('a')
        l.click()

        self.assertEqual("Hi", self.body_text())
