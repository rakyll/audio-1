#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

int audio_open(char* name, ExtAudioFileRef* file) {
  CFStringRef urlStr = CFStringCreateWithCString(kCFAllocatorDefault, name, kCFStringEncodingUTF8);
  CFURLRef urlRef = CFURLCreateWithFileSystemPath(NULL, urlStr, kCFURLPOSIXPathStyle, false);

  OSStatus err;
  err = ExtAudioFileOpenURL(urlRef, file);

  CFRelease(urlStr);
  CFRelease(urlRef);

  return err;
}

int audio_parseheader(ExtAudioFileRef file, uint32_t* bitDepth, uint32_t* numChannels, uint32_t* sampleRate, uint32_t* audioSize) {
  AudioStreamBasicDescription iformat;
  UInt32 size = sizeof(iformat);

  OSStatus err;
  err = ExtAudioFileGetProperty(file, kExtAudioFileProperty_FileDataFormat, &size, &iformat);
  if (err != noErr) {
    return err;
  }

  *numChannels = (int)iformat.mChannelsPerFrame;
  *bitDepth = (int)iformat.mBytesPerFrame/iformat.mChannelsPerFrame;
  *sampleRate = (int)(iformat.mSampleRate); // convert to float64?
  // calculate the audioSize
  return 0;
}

int audio_seek(ExtAudioFileRef file, int sampleIndex) {
  return 0;
}

// TODO(jbd): implement audio_readInt and audio_readFloat.
int audio_read(ExtAudioFileRef file, int size, uint numChannels, const float* dst) {
  OSStatus err;

  uint totalFrames = size/numChannels;
  uint framesToRead = totalFrames;

  uint numReadFrames = 0; // numReadFrames could be less than totalFrames.

  while (framesToRead < totalFrames) {
    AudioBufferList bufList;
    bufList.mNumberBuffers = 1;
    bufList.mBuffers[0].mNumberChannels = numChannels;
    bufList.mBuffers[0].mDataByteSize = framesToRead * numChannels * sizeof(float);
    bufList.mBuffers[0].mData = (void*)(&dst[framesToRead * numChannels]);

    UInt32 numFrames;
    err = ExtAudioFileRead(file, &numFrames, &bufList);
    if (err != noErr) {
      return err;
    }
    if (numFrames == 0) {
      break;
    }
    framesToRead = totalFrames - numFrames;
    numReadFrames += numFrames;
  }
  return 0;
}

int audio_close(ExtAudioFileRef file) {
  return ExtAudioFileDispose(file);
}