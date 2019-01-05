import unittest
import base

class Suite(base.Base):
    def test_1(self):
        """Test case 1"""
        self.start('Ctextarea/main')

        # initial state
        self.assertEqual('DEFAULT', self.xpath('p/span').text)

        ta = self.xpath('textarea')

        ta.send_keys(' typing stuff out')

        self.assertEqual("DEFAULT typing stuff out", self.xpath('p/span').text)
