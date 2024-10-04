{ pkgs, ... }:

{
  home.packages = [ pkgs.bluetuith ];

  xdg.configFile."bluetuith/bluetuith.conf".text = ''
    {
      adapter: ""
      adapter-states: ""
      connect-bdaddr: ""
      gsm-apn: ""
      gsm-number: ""
      receive-dir: ""

      keybindings: {
        NavigateUp: k
        NavigateDown: j
        NavigateLeft: h
        NavigateRight: l

        NavigateTop: g
        NavigateBottom: G

        ProgressTransferResume: Ctrl+G
      }

      theme: {
        Adapter: "blue"
        AdapterDiscoverable: "purple"
        AdapterNotPowered: "red"
        AdapterPairable: "teal"
        AdapterPowered: "yellow"
        AdapterScanning: "gray"

        DeviceConnected: "green"

        Border: "yellow"
      }
    }
  '';
}
