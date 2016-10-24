//============================================================================
// Name        : graphmap-server-daemon.cpp
// Author      : Ivan Sovic
// Version     :
// Copyright   : Copyright Ivan Sovic, 2014. All rights reserved.
// Description : Server daemon process for web-based GraphMap service.
//============================================================================

#include "daemon.h"

int main(int argc, char *argv[]) {
  bool is_dry_run = false;
  std::string input_folder="", output_folder="", processing_folder="", command_line="", task_extension="";

  if (argc < 5) {
    fprintf (stderr, "Usage:\n");
    fprintf (stderr, "\t%s <input_folder> <output_folder> <processing_folder> task_file_extension [--dryrun]\n", argv[0]);
    fprintf (stderr, "\n");
    fprintf (stderr, "Example:\n");
    fprintf (stderr, "./graphmap-server-daemon /home/graphmap/upload /home/graphmap/done /home/graphmap/processing task\n");
    fflush (stderr);
    exit(1);
  }

  input_folder = argv[1];
  output_folder = argv[2];
  processing_folder = argv[3];
  task_extension = argv[4];

  if (argc > 5) {
    if (std::string(argv[5]) == "--dryrun") {
      is_dry_run = true;
    }
  }

  Daemon::GetInstance().Run(input_folder, output_folder, processing_folder, task_extension, is_dry_run);
  
  return 0;
}
