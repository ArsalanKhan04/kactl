/**
 * Author: ChatGPT
 * Date: 2015-02-06
 * License: CC0
 * Source: Folklore
 * Description: Convex Hull Trick.
 * Usage:
 *  CHT cht;
 *  cht.add(slope, intercept);
 *  cht.get(x);
 * Time: $O(N)$ for all additions, $O(\log N)$ for queries
 * Status: To be Tested
 */
#pragma once

#include <bits/stdc++.h>
using namespace std;

typedef int ftype;
typedef complex<ftype> point;
#define x real
#define y imag

ftype dot(point a, point b) { return (conj(a) * b).x(); }
ftype cross(point a, point b) { return (conj(a) * b).y(); }

template<class T>
struct CHT {
    vector<point> hull, vecs;
    void add(T k, T b) {
        point nw = {k, b};
        while (!vecs.empty() && dot(vecs.back(), nw - hull.back()) < 0) {
            hull.pop_back();
            vecs.pop_back();
        }
        if (!hull.empty()) vecs.push_back(1i * (nw - hull.back()));
        hull.push_back(nw);
    }
    T get(T x) {
        point q = {x, 1};
        auto it = lower_bound(vecs.begin(), vecs.end(), q, [](point a, point b) {
            return cross(a, b) > 0;
        });
        return dot(q, hull[it - vecs.begin()]);
    }
};

