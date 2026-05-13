{config,...}:
{
  programs.qutebrowser = {
    enable = true;
    searchEngines = {
      DEFAULT = "https://search.brave.com/search?q={}";
    };
    settings = {
      content.blocking.method = "both";
      tabs = {
        show = "multiple";
        title.format = "{audio}{current_title}";
      };
      url = {
        start_pages = "about:blank";
      };
      colors = {
        webpage.bg = "${config.lib.stylix.colors.withHashtag.base00}";
      };
      completion = {
        web_history.max_items = 0;
      };
    };
  };
  stylix.targets.qutebrowser.colors.enable = true;
}
