import unittest
import base

class Suite(base.Base):
    def test_1(self):
        """Test case 1"""
        self.start('main')
        s1 = self.xpath('span[1]')
        self.assertEqual("", s1.get_attribute("class"))

        s2 = self.xpath('span[2]')
        self.assertEqual(" spicy", s2.get_attribute("class"))
