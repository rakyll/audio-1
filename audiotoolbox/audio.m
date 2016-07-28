#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

int audio_open(char* name, ExtAudioFileRef* file) {
  CFStringRef urlStr = CFStringCreateWithCString(kCFAllocatorDefault, name, kCFStringEncodingUTF8);
  CFURLRef urlRef = CFURLCreateWithFileSystemPath(NULL, urlStr, kCFURLPOSIXPathStyle, false);

  OSStatus err;
  err = ExtAudioFileOpenURL(urlRef, file);

  CFRelease(urlStr);
  CFRelease(urlRef);

  // TODO(jbd): provide more detailed error code if failed.
  if (err != noErr) {
    return -1;
  }

  return 0;
}

int audio_parseheader(ExtAudioFileRef file, uint* bitDepth, uint* numChannels, uint* sampleRate, uint* audioSize) {
  AudioStreamBasicDescription iformat;
  UInt32 size = sizeof(iformat);

  OSStatus err;
  err = ExtAudioFileGetProperty(file, kExtAudioFileProperty_FileDataFormat, &size, &iformat);
  // TODO(jbd): provide more detailed error code if failed.
  if (err != noErr) {
    return -1;
  }

  *numChannels = (int)iformat.mChannelsPerFrame;
  *bitDepth = (int)iformat.mBytesPerFrame/iformat.mChannelsPerFrame;
  *sampleRate = (int)(iformat.mSampleRate); // convert to float64?
  // calculate the audioSize
  return 0;
}

int audio_seek(ExtAudioFileRef f, int sampleIndex) {
  return 0;
}

int audio_read(ExtAudioFileRef f, int size, const uint8_t* dst) {
  return 0;
}

int audio_close(ExtAudioFileRef file) {
  return ExtAudioFileDispose(file);
}