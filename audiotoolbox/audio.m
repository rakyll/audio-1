#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

int open_audio(char* name) {
  CFStringRef urlStr = CFStringCreateWithCString(kCFAllocatorDefault, name, kCFStringEncodingUTF8);
  CFURLRef urlRef = CFURLCreateWithFileSystemPath(NULL, urlStr, kCFURLPOSIXPathStyle, false);

  ExtAudioFileRef file;
  OSStatus err;
  err = ExtAudioFileOpenURL(urlRef, &file);
  CFRelease(urlStr);
  CFRelease(urlRef);

  // TODO(jbd): Handle error.

  AudioStreamBasicDescription inputFormat;
  UInt32 size = sizeof(inputFormat);
  err = ExtAudioFileGetProperty(file, kExtAudioFileProperty_FileDataFormat, &size, &inputFormat);

  return 0;
}

int seek_audio(int sampleIndex) {
  return 0;
}

int read_audio(int size, const uint8_t* dst) {
  return 0;
}

int close_audio(int fid) {
  return 0;
}