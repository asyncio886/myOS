#include "list.h"
#ifdef __INCLUDE_LIST
#include "global.h"
#include "interrupt.h"
void list_init(struct list* plist) {
    plist->head.prev = NULL;
    plist->tail.next = NULL;
    plist->head.next = &plist->tail;
    plist->tail.prev = &plist->head;
}
void list_insert_before(struct list_elem* before, struct list_elem* elem) {
    // 队列要保证线程安全，在这里需要阻止外部中断
    enum intr_status old_status = intr_disable();
    struct list_elem* prev = before->prev;
    prev->next = elem;
    before->prev = elem;
    elem->prev = prev;
    elem->next = before;
    // 恢复
    intr_set_status(old_status);
}
/*
    push是加到队头
*/
void list_push(struct list* plist, struct list_elem* elem) {
    list_insert_before(plist->head.next, elem);
}
void list_iterate(struct list* plist) {

}
/*
    append添加到队尾
*/
void list_append(struct list* plist, struct list_elem* elem) {
    list_insert_before(&plist->tail, elem);
}
void list_remove(struct list_elem* elem) {
    // 同样关中断
    enum intr_status old_status = intr_disable();
    elem->prev->next = elem->next;
    elem->next->prev = elem->prev;
    intr_set_status(old_status);
}
struct list_elem* list_pop(struct list* plist) {
    struct list_elem* last_elem = plist->head.next;
    list_remove(last_elem);
    return last_elem;
}
uint8_t list_empty(struct list* plist) {
    return plist->head.next == &plist->tail && plist->tail.prev == &plist->head;
}
uint32_t list_len(struct list* plist) {
    int len = 0;
    struct list_elem* ptr = &plist->head;
    while (ptr->next != &plist->tail)
    {
        len++;
        ptr = ptr->next;
    }
    return len;
}
/*
回调函数遍历出符合条件的节点
*/
struct list_elem* list_traversal(struct list* plist, function func, int arg) {
    if(list_empty(plist)) {
        return NULL;
    }
    struct list_elem* elem = plist->head.next;
    while (elem != &plist->tail)
    {
        if(func(elem, arg)) {
            return elem;
        }
        elem = elem->next;
    }
    return NULL;
}
uint8_t elem_find(struct list* plist, struct list_elem* obj_elem) {
    struct list_elem* ptr = &plist->head;
    while (ptr->next != &plist->tail)
    {
        if(ptr->next == obj_elem) {
            return 1;
        }
        ptr = ptr->next;
    }
    return 0;
}
void debug_list(struct list* plist) {
    struct list_elem* elem = plist->head.next;
    while (elem != &plist->tail)
    {
       print_str("list_elem is ");
       print_num((uint32_t) elem);
       print_str("\n");
       elem = elem->next;
    }
    
}


#endif