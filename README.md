# Mailbox

Time Spent: 29 hours<br>

Tasks Completed: 

On dragging the message left...
- [x] REQ: Initially, the revealed background color should be gray.
- [x] REQ: As the reschedule icon is revealed, it should start semi-transparent and become fully opaque. If released at this point, the message should return to its initial position.
- [x] REQ: After 60 pts, the later icon should start moving with the translation and the background should change to yellow.
  - [x] REQ: Upon release, the message should continue to reveal the yellow background. When the animation it complete, it should show the reschedule options.
- [x] REQ: After 260 pts, the icon should change to the list icon and the background color should change to brown.
  - [x] REQ: Upon release, the message should continue to reveal the brown background. When the animation it complete, it should show the list options.
- [x] REQ: User can tap to dismissing the reschedule or list options. After the reschedule or list options are dismissed, you should see the message finish the hide animation.
On dragging the message right...
- [x] REQ: Initially, the revealed background color should be gray.
- [x] REQ: As the archive icon is revealed, it should start semi-transparent and become fully opaque. If released at this point, the message should return to its initial position.
- [x] REQ: After 60 pts, the archive icon should start moving with the translation and the background should change to green.
  - [x] REQ: Upon release, the message should continue to reveal the green background. When the animation it complete, it should hide the message.
- [x] REQ: After 260 pts, the icon should change to the delete icon and the background color should change to red.
  - [x] REQ: Upon release, the message should continue to reveal the red background. When the animation it complete, it should hide the message.
- [x] Optional: Panning from the edge should reveal the menu
- [x] Optional: If the menu is being revealed when the user lifts their finger, it should continue revealing.
- [x] Optional: If the menu is being hidden when the user lifts their finger, it should continue hiding.
- [x] Optional: Tapping on compose should animate to reveal the compose view.
- [x] Optional: Tapping the segmented control in the title should swipe views in from the left or right.
- [x] Optional: Shake to undo.

GIF walkthrough including optional tasks:<br><br>
![Alt text](https://github.com/flamencoflsh/Mailbox/blob/master/Mailbox/Assets.xcassets/Mailbox.gif)
