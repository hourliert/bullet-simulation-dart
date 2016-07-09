# bullet-simulation-dart
[![Build Status][travis-badge]][travis-link]

Dart version of [bullet-simulation][bullet-simulation-js].

This is a bullet game simulation. The user can click anywhere in the page to launch a bullet.
It has a random velocity and a random angle and follow a random trajectory.
When this bullet hits a border, a popup with some of its information is shown.

## Getting started
This project follows dart recommendations. So you could do:

```
pub serve # view the dev version
pub run test # run the unit tests
pub build --mode=release # build the prod version
dartdoc # generator the API doc
```


[travis-badge]: https://travis-ci.org/hourliert/bullet-simulation-dart.svg?branch=master
[travis-link]: https://travis-ci.org/hourliert/bullet-simulation-dart

[bullet-simulation-js]: https://github.com/hourliert/bullet-simulation