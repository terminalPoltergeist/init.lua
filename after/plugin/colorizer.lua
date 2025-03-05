require'colorizer'.setup({
  javascript = { names = false },
  css = {
    names = false;
    rgb_fn = true;
  },
  xml = {
    names = false;
    mode = 'background'
  },
  yaml = {
    mode = 'background'
  },
  go = {
    mode = 'background'
  }
}, { mode = 'foreground' })
