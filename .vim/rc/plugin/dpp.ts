import {
  BaseConfig,
  ConfigReturn,
  ContextBuilder,
  Dpp,
  Plugin,
} from "https://deno.land/x/dpp_vim@v0.0.9/types.ts";
import { Denops } from "https://deno.land/x/dpp_vim@v0.0.9/deps.ts";
import { expandGlob } from "https://deno.land/std@0.212.0/fs/expand_glob.ts";

type Toml = {
  hooks_file?: string;
  ftplugins?: Record<string, string>;
  plugins?: Plugin[];
};

type LazyMakeStateResult = {
  plugins: Plugin[];
  stateLines: string[];
};

export class Config extends BaseConfig {
  override async config(args: {
    denops: Denops;
    contextBuilder: ContextBuilder;
    basePath: string;
    dpp: Dpp;
  }): Promise<ConfigReturn> {
    args.contextBuilder.setGlobal({
      protocols: ["git"],
    });

    const [context, options] = await args.contextBuilder.get(args.denops);

    // Load toml plugins
    const tomls: Toml[] = [];
    for (
      const tomlFile of [
        "~/.vim/rc/plugin/dein.toml",
      ]
    ) {
      const toml = await args.dpp.extAction(
        args.denops,
        context,
        options,
        "toml",
        "load",
        {
          path: tomlFile,
          options: {
            lazy: false,
          },
        },
      ) as Toml | undefined;

      if (toml) {
        tomls.push(toml);
      }
    }

    // Merge toml results
    const recordPlugins: Record<string, Plugin> = {};
    const ftplugins: Record<string, string> = {};
    const hooksFiles: string[] = [];
    for (const toml of tomls) {
      for (const plugin of toml.plugins ?? []) {
        recordPlugins[plugin.name] = plugin;
      }

      if (toml.ftplugins) {
        for (const filetype of Object.keys(toml.ftplugins)) {
          if (ftplugins[filetype]) {
            ftplugins[filetype] += `\n${toml.ftplugins[filetype]}`;
          } else {
            ftplugins[filetype] = toml.ftplugins[filetype];
          }
        }
      }

      if (toml.hooks_file) {
        hooksFiles.push(toml.hooks_file);
      }
    }
    //
    // const lazyResult = await args.dpp.extAction(
    //   args.denops,
    //   context,
    //   options,
    //   "lazy",
    //   "makeState",
    //   {
    //     plugins: Object.values(recordPlugins),
    //   },
    // ) as LazyMakeStateResult | undefined;

    const checkFiles = [];
    for await (const file of expandGlob(`${Deno.env.get("BASE_DIR")}/*`)) {
      checkFiles.push(file.path);
    }

    return {
      checkFiles,
      ftplugins,
      hooksFiles,
      plugins: Object.values(recordPlugins),
    };
  }
}
