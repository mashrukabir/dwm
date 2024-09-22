const unsigned int interval = 500; /* interval ms */
static const char unknown_str[] = "n/a"; /* No value; text */
#define MAXLEN 2048 /* maximum output string length */

static const struct arg args[] = {
	/* function format          argument */
        { datetime, "%s  ",           " %I:%M %p   %e %B, %A %Y"},
        { cpu_perc, "   %s%%",        NULL },
        { ram_used, "    %s",          NULL },
        { run_command, "    %s ", "pamixer --get-volume" },
        { battery_perc,  "    %s%% ", "BAT0" },
};
