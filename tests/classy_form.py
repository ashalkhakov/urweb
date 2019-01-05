import unittest
import base

class Suite(base.Base):
    def test_1(self):
        """Test case 1"""
        self.start('main')
        f = self.xpath('form')
        # NOTE: the "_" vs the "-" in the source!
        self.assertEqual("form_inline", f.get_attribute("class"))
