#include "print.h"
#ifdef __INCLUDE_PRINT
#include "type.h"
void print_str(char *str)
{
    int index = 0;
    while (str[index] != '\0')
    {
        put_char(str[index++]);
    }
}
void clear_screen()
{
    to_top_left();
    int max_index = 80 * 25;
    int i;
    for (i = 0; i < max_index; i++)
    {
        put_char(' ');
    }
    to_top_left();
}

void print_num(uint32_t num)
{
    uint32_t template = 0xF0000000;
    int i;
    print_str("0x");
    for (i = 0; i < 8; i++)
    {
        uint8_t value = (num & template) >> 28;
        if (value >= 0 && value < 10)
        {
            put_char('0' + value);
        }
        else
        {
            put_char('a' + (value % 10));
        }
        num <<= 4;
    }
}
void print_dec(uint32_t num)
{
    if (num == 0)
    {
        put_char('0');
    }
    uint32_t order = 1;
    if (num >= 2000000000)
    {
        order = 1000000000;
    }
    else
    {
        while (order < num)
        {
            order *= 10;
        }
        if (order > num)
        {
            order /= 10;
        }
    }
    while (order != 0)
    {
        put_char('0' + (num / order));
        num %= order;
        order /= 10;
    }
}
void print_format(char *str, uint32_t num)
{
    int i = 0;
    while (str[i] != '\0')
    {
        if (str[i] == '%')
        {
            if (str[i + 1] != '\0' && str[i + 1] == 'd')
            {
                print_dec(num);
                i++;
            }
            else if (str[i + 1] != '\0' && str[i + 1] == 'x')
            {
                print_num(num);
                i++;
            }
        }
        else
        {
            put_char(str[i]);
        }
        i++;
    }
    put_char('\n');
}

void println(char* str) {
    print_str(str);put_char('\n');
}
#endif