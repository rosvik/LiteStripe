char helpKey = 'h';
char activeKey = 'd';
char infoKey = 'i';
char refreshKey = 'r';

void keyPressed() {
  if (key == activeKey) {
    toggleActive();
  }
  if (key == infoKey) {
    syphonInfo();
  }
  if (key == refreshKey) {
    refreshInfo();
  }
  if (key == helpKey) {
    helpInfo();
  }
}