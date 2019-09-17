# LiteStrip

LiteStrip is a tool that uses live data from [ProPresenter 6](https://renewedvision.com/propresenter/) to animate LED strips in real time. A Processing server uses a [Syphon](http://syphon.v002.info/) stream to read image data from ProPresenter. Some of the color values are passed on to an Arduino via a serial port, and the Arduino lights up LED strips with the corresponding colors.

## Installation

### Server

1. Open `server.pde` in [Processing 3](https://processing.org/download/)
2. Go to Sketch > Import Library... > Import Library... 
3. Search for and install "Syphon"
4. In ProPresenter Settings > Display > Enable Syphon should be selected
5. Run the Processing project (Cmd + R)

### Client

1. Upload `board.ino` to your Arduino
