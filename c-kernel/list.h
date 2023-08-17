#ifndef __INCLUDE_LIST
#define __INCLUDE_LIST
#include "type.h"
#define offset(struct_type, member) (int)(&((struct_type *)0)->member)
#define elem2entry(struct_type, struct_member_name, elem_ptr) \
    (struct_type *)((int)elem_ptr - offset(struct_type, struct_member_name))
// 没有数据成员
struct list_elem {
    struct list_elem *prev;
    struct list_elem *next;
};
typedef uint8_t function(struct list_elem* elem, int arg);
struct list {
    struct list_elem head;
    struct list_elem tail;
};
void list_init(struct list*);
void list_insert_before(struct list_elem* before, struct list_elem* elem);
void list_push(struct list* plist, struct list_elem* elem);
void list_iterate(struct list* plist);
void list_append(struct list* plist, struct list_elem* elem);
void list_remove(struct list_elem* elem);
struct list_elem* list_pop(struct list* plist);
uint8_t list_empty(struct list* plist);
uint32_t list_len(struct list* plist);
struct list_elem* list_traversal(struct list* plist, function func, int arg);
uint8_t elem_find(struct list* plist, struct list_elem* obj_elem);
struct list_elem* list_pop(struct list* plist);
void debug_list(struct list* plist);
#endif