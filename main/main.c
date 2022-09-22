extern void appinit(void);
extern void app__main(void);

void app_main(void)
{
    appinit();
    app__main();
}
