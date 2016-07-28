package audiotoolbox

// #cgo CFLAGS: -I/usr/local/include
// #cgo LDFLAGS: -framework CoreAudio -framework AudioToolbox -framework Foundation
//
// #import <stdint.h>
// #import <AudioToolbox/AudioToolbox.h>
//
// int audio_open(char* name, ExtAudioFileRef* file);
// int audio_parseheader(ExtAudioFileRef file, uint* bitDepth, uint* numChannels, uint* sampleRate, uint* audioSize);
// int audio_seek(ExtAudioFileRef file, int sampleIndex);
// int audio_read(ExtAudioFileRef file, int size, const uint8_t* dst);
// int audio_close(ExtAudioFileRef file);
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
