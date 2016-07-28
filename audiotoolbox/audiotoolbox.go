package audiotoolbox

// #cgo CFLAGS: -I/usr/local/include
// #cgo LDFLAGS: -framework CoreAudio -framework AudioToolbox -framework AudioUnit -framework Foundation
//
// #import <stdint.h>
// int open_audio(char* name);
// int seek_audio(int sampleIndex);
// int read_audio(int size, const uint8_t* dst);
// int close_audio(int fid);
import "C"

import (
	"github.com/mattetti/audio"
)

func NewDecoder(filename string) (*Decoder, error) {
	panic("not implemented")
}

type Decoder struct {
	handle uintptr
}

func (d *Decoder) PCM() (audio.PCM, error) {
	panic("not implemented")
}

func (d *Decoder) Close() error {
	panic("not implemented")
}
