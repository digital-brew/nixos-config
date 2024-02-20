# SPDX-License-Identifier: MIT
# (C) 2022 The Asahi Linux Contributors

{ config, pkgs, ... }:

let
  t2AppleAudioDSP = pkgs.fetchFromGitHub {
    owner = "lemmyg";
    repo = "t2-apple-audio-dsp";
    rev = "01bd2d40662eef7bdeb65eef5231e6d57737edd0"; # Last: 8bc1859ddf4bbc8ed9efaf2132fb3c5a466e1890
    sha256 = "15UAP7A4JkQRmESl3tlO7pgq2marewk+f49FjZ5cRyc="; # Last: aOIY8tchFjrflwmTWx5cxWpVm9G71lN4LH0lXvEVwWs=
  };
  micConfigFile = "${t2AppleAudioDSP}/config/10-t2_mic.conf";
  headsetMicConfigFile = "${t2AppleAudioDSP}/config/10-t2_headset_mic.conf";
in
{
  environment.etc."pipewire/pipewire.conf.d/10-t2_mic.conf".source = micConfigFile;
  environment.etc."pipewire/pipewire.conf.d/10-t2_headset_mic.conf".source = headsetMicConfigFile;
}