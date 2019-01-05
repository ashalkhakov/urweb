import unittest
import urllib.request

class Suite(unittest.TestCase):
    def test_1(self):
        """Test case 1"""
        with urllib.request.urlopen('http://localhost:8080/main') as response:
            html = response.read()
            self.assertEqual(b'Hi there!', html)
            self.assertEqual('attachment; filename=test.txt', response.getheader('Content-Disposition'))
