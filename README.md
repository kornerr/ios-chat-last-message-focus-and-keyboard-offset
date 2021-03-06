
# Overview

This is a sample iOS application with the following features:

* scroll to the last message upon entering chat window
* scroll to the last message upon receiving new message
* lift messages when keyboard is visible
* work with iOS11 "famous" adjusted content inset

Here's preview of the application running on:

* iOS 10

![preview][preview-ios10]

* iOS 11 (iPhone X)

![preview][preview-ios11]

# Details

Here's a simplified hierarchy of most important parts of Chat VC:

* UITabBarController
    * UINavigationController
        * UIViewController
            * UITableView
            * SendView

The application makes use of the following classes/components in External directory:

* Keyboard
    * Provides notifications of keyboard show/hide states
    * Provides keyboard height
* TableViewCellTemplate
    * Provides an easy way to display any view inside UITableView's cell
* UIView+Embed
    * Embeds child view into parent one by binding corresponding top, bottom, left, right anchors
* UIView+NibFile
    * Allows to easily load NIB (XIB) for later embedding into host UIView

[preview-ios10]: readme/preview-ios10.gif
[preview-ios11]: readme/preview-ios11.gif
