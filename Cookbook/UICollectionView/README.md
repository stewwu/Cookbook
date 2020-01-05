#  Collection View

##  較小寬度 cell 的分頁特效 (PagedSmallBannerViewController)

當 cell 的大小比 collection view 小時，scroll view 的 paging 捲動就跟 cell 大小不一致，所以在這個範例中實作了只捲動 cell 大小的 paging 特效。其中有三段 code 分別有以下的特效：

1.  類似 paging，需要捲動超過一半的距離，同時減速動畫是固定速率
2.  類似一般的 scroll view，但會停在上或下一筆的邊邊，減速動畫根據施力有不同的速率
3.  類似一般的 scroll view，但會停在某一筆的邊邊，減速動畫根據施力有不同的速率


##  旋轉木馬式的捲動特效 (LoopedCarouselViewController)

讓 collection view 可以像旋轉木馬一樣無止境的捲動。
