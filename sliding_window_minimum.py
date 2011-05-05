#!/usr/bin/env python

'''Implementation of Sliding Window Minimum Algorithm. This module contains
one function `sliding_window_minimum`.

See http://people.cs.uct.ac.za/~ksmith/articles/sliding_window_minimum.html
for a longer explanation of the algorithm.'''

from collections import deque

__author__ = "Keegan Carruthers-Smith"
__email__ = "keegan.csmith@gmail.com"
__license__ = "MIT"


def sliding_window_minimum(k, li):
    '''
    A iterator which takes the size of the window, `k`, and an iterable,
    `li`. Then returns an iterator such that the ith element yielded is equal
    to min(list(li)[max(i - k + 1, 0):i+1]).

    Each yield takes amortized O(1) time, and overall the generator takes O(k)
    space.
    '''

    window = deque()
    for i, x in enumerate(li):
        while window and window[-1][0] >= x:
            window.pop()
        window.append((x, i))
        while window[0][1] <= i - k:
            window.popleft()
        yield window[0][0]


if __name__ == '__main__':
    import sys
    k = int(sys.argv[1])
    li = map(int, sys.argv[2:])
    for x in sliding_window_minimum(k, li):
        print x
