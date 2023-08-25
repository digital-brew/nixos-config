{ pkgs, lib, ... }:

{
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    knownHosts = {
      id_ed_muchmore.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKRmj+PlCNU7I3eH7kK/uW+vbR9eG3SdIbEFfNT/VU39 rafal@muchmorecreative.co.uk";
      id_ed_digitalbrew.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDRpDYY6c5pggmFbgCGT/9+wu4nOI0EQ1/d53RHiFySx rafal@digitalbrew.io";
      id_rsa.publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC8p6AFFYtjzqgm+I8T9QR+BtrRE9o02umcnvpKrYZNnCSknAEbuRqQDUUUsRWGEed4PP1j762JJsfyi+CQmxjxoIfAS77vBccerQsUsEQs7B5BF61tkvZhJw6Rpncv/luEw+yJm/7WvzC2ffftMgYhxSSTa21ZCGQJq7ZYck5rOzqR7y+A/oBVm6FVX2WqmdZWFYkLhEOvsrt8oPVz61b9i9IwD98HoBon5wFLEx1XZuPq3sYi0zw7VKMHoa5NsEZq0WiOfRviDRVPB2eyYbN24J4ZQjgHbh3JfBnsrd7c/MgtGNtcJEwGGCBxkb/EwsdImX6HWFgos3rU/+toRFyjTFExMN6M7ucL8HmHCJws1rP7SjMQ7sZr9DHoNZNvr9/xhlVe4xM9jMdCeoUnzRNap6Z2nymj03aG8r0mVziwz80HwtbAlAI2LBGuaDVr+ZnH/J3gCJ8GekfG8mCij5KY4s58zPaFRgZQKMFTP/yk5+CjOgL0OyYczHnxww6L7pi1By63KRT72r1KooEeYwHIbKEF+IQFpLTYNfbWxl8+6zLVB47SLyfZIdwUuWasSLOXZldbYbjNDJPrjj0j9gJRcpnQE2owIjuevmEromY/Kc10wk7ZF2t56JMHNoJ4+7l9g4EAdMje2S/sVLdwIfJI9JNleprQfjKq1Xy8Pc4VBw== rafal@burstofcode.com";
    };
  };
}