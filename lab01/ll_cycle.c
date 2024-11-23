#include <stddef.h>
#include "ll_cycle.h"

int ll_has_cycle(node *head) {
    /* your code here */
    if (!head) {
        return 0;
    }
    node *tortoise = head;
    node *hare = head;
    while (tortoise -> next) {
        for (int i = 0; i < 2; ++i) {
            if (hare -> next) {
                hare = hare -> next;
                if (hare == tortoise) {
                    return 1;
                }
            } else {
                return 0;
            }
        }
        tortoise = tortoise -> next;
        if (hare == tortoise) {
            return 1;
        }
    }
    return 0;
}