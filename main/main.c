extern void adainit(void);
extern void _ada_app(void);

void app_main(void)
{
    adainit();
    _ada_app();
}
