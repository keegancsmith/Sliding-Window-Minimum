#include <cstdlib>
#include <deque>
#include <iostream>
#include <vector>

int main(int argc, char **argv) {
    // Usage ./sliding_window_minimum K arr[0] arr[1] ... arr[N-1]
    int K = atoi(argv[1]);

    std::deque< std::pair<int, int> > window;
    for (int i = 2; i < argc; i++) {
        int val = atoi(argv[i]);
        while (!window.empty() && window.back().first >= val)
            window.pop_back();
        window.push_back(std::make_pair(val, i));

        while(window.front().second <= i - K)
            window.pop_front();

        std::cout << (window.front().first) << '\n';
    }
}
