import 'dart:convert';
import 'dart:math';

import '../core/enums/encoding_type.dart';

class EncodingHelper {
  static String encodeMessage(String message, EncodingType type) {
    switch (type) {
      case EncodingType.hexadecimal:
        return _hexEncode(message);
      case EncodingType.base32:
        return _base32Encode(message);
      case EncodingType.base85:
        return _base85Encode(message);
      case EncodingType.urlEncoding:
        return _urlEncode(message);
    }
  }

  // Hexadecimal Encoding
  static String _hexEncode(String message) {
    return message.codeUnits
        .map((unit) => unit.toRadixString(16).padLeft(2, '0'))
        .join(' ');
  }

  // Base32 Encoding
  static String _base32Encode(String message) {
    const String alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';
    List<int> bytes = utf8.encode(message);
    StringBuffer result = StringBuffer();
    int buffer = 0;
    int bufferLength = 0;

    for (int byte in bytes) {
      buffer = (buffer << 8) | byte;
      bufferLength += 8;

      while (bufferLength >= 5) {
        bufferLength -= 5;
        result.write(alphabet[(buffer >> bufferLength) & 31]);
      }
    }

    if (bufferLength > 0) {
      buffer = buffer << (5 - bufferLength);
      result.write(alphabet[buffer & 31]);
    }

    // Add padding
    while (result.length % 8 != 0) {
      result.write('=');
    }

    return result.toString();
  }

  // Base85 Encoding
  static String _base85Encode(String message) {
    const String alphabet = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!#\$\%&()*+-;<=>?@^_`{|}~';
    List<int> bytes = utf8.encode(message);
    StringBuffer result = StringBuffer();

    for (int i = 0; i < bytes.length; i += 4) {
      int value = 0;
      int count = 0;

      // Convert up to 4 bytes to a 32-bit integer
      for (int j = 0; j < 4 && i + j < bytes.length; j++) {
        value = (value << 8) | bytes[i + j];
        count++;
      }

      // Encode the integer as 5 Base85 characters
      if (count > 0) {
        for (int j = 4; j >= 0; j--) {
          if (j <= count) {
            int code = (value ~/ pow(85, j)) % 85;
            result.write(alphabet[code]);
          }
        }
      }
    }

    return result.toString();
  }

  // URL Encoding with custom mapping
  static String _urlEncode(String message) {
    final specialChars = {
      ' ': '%20',
      '!': '%21',
      '"': '%22',
      '#': '%23',
      '\$': '%24',
      '%': '%25',
      '&': '%26',
      "'": '%27',
      '(': '%28',
      ')': '%29',
      '*': '%2A',
      '+': '%2B',
      ',': '%2C',
      '/': '%2F',
      ':': '%3A',
      ';': '%3B',
      '=': '%3D',
      '?': '%3F',
      '@': '%40',
      '[': '%5B',
      ']': '%5D'
    };

    return message.split('').map((char) {
      if (specialChars.containsKey(char)) {
        return specialChars[char];
      }
      return char;
    }).join('');
  }
}
