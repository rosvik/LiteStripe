# LiteStrip (Work in progress)

LiteStrip is a tool that uses live data from [ProPresenter 6](https://renewedvision.com/propresenter/) to animate LED strips in real time. A Processing server uses a [Syphon](http://syphon.v002.info/) stream to read image data from ProPresenter. Some of the color values are passed on to an Arduino via a serial port, and the Arduino lights up LED strips with the corresponding colors.
