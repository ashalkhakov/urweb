import unittest
import base

class Suite(base.Base):
    def v(self, e):
        return e.get_attribute('value')
    def test_1(self):
        """Test case 1"""
        self.start('main')

        t1 = self.xpath('input[1]')
        t2 = self.xpath('input[2]')

        # initial state
        self.assertEqual('Initial', self.xpath('span').text)
        self.assertEqual('Initial', self.v(t1))
        self.assertEqual('Initial', self.v(t2))

        t1.send_keys('?')

        self.assertEqual("Initial?", self.xpath('span').text)
        self.assertEqual("Initial?", self.v(t1))
        self.assertEqual("Initial?", self.v(t2))

        t2.send_keys('?')
        self.assertEqual("Initial??", self.xpath('span').text)
        self.assertEqual("Initial??", self.v(t1))
        self.assertEqual("Initial??", self.v(t2))
