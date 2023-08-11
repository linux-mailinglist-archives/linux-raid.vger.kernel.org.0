Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9136A7795AC
	for <lists+linux-raid@lfdr.de>; Fri, 11 Aug 2023 19:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbjHKRHT (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 11 Aug 2023 13:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbjHKRHR (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 11 Aug 2023 13:07:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6633C211C;
        Fri, 11 Aug 2023 10:07:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 25D841F8AB;
        Fri, 11 Aug 2023 17:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691773631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B4nSDUDXQCOTeuYGGPNbQSsIbtSNnHYh+f9UXAH7VtI=;
        b=XoyYRNxbVqGVFqyX7jjngIA/EkGJ2tJsb8M9D1e4MHzJbM6lvA141S07EM1L4NmuiZWAju
        yajQxjj0ULWifYBSvI8U67tH4XI1SF52a0eZZbbKQL0Ux2Jo0Pt4ekGGpO9GpYPAHf7lCo
        +guy3oWKKbry9yh5w0H4CVvRajZIQOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691773631;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B4nSDUDXQCOTeuYGGPNbQSsIbtSNnHYh+f9UXAH7VtI=;
        b=F1XGX5qUJhk5ouIDGGXXq5nNZYKjsfZ8G4+c3Y5nYpOKR9y5vAtoP6A1h++dsbU3HekWwl
        gHa6jNjaoNl/yPBQ==
Received: from localhost.localdomain (colyli.tcp.ovpn1.nue.suse.de [10.163.16.22])
        by relay2.suse.de (Postfix) with ESMTP id 4ABD22C143;
        Fri, 11 Aug 2023 17:07:07 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-raid@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-block@vger.kernel.org
Cc:     Coly Li <colyli@suse.de>, Dan Williams <dan.j.williams@intel.com>,
        Geliang Tang <geliang.tang@suse.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        NeilBrown <neilb@suse.de>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Xiao Ni <xni@redhat.com>
Subject: [PATCH v7 2/6] badblocks: add helper routines for badblock ranges handling
Date:   Sat, 12 Aug 2023 01:05:08 +0800
Message-Id: <20230811170513.2300-3-colyli@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230811170513.2300-1-colyli@suse.de>
References: <20230811170513.2300-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

This patch adds several helper routines to improve badblock ranges
handling. These helper routines will be used later in the improved
version of badblocks_set()/badblocks_clear()/badblocks_check().

- Helpers prev_by_hint() and prev_badblocks() are used to find the bad
  range from bad table which the searching range starts at or after.

- The following helpers are to decide the relative layout between the
  manipulating range and existing bad block range from bad table.
  - can_merge_behind()
    Return 'true' if the manipulating range can backward merge with the
    bad block range.
  - can_merge_front()
    Return 'true' if the manipulating range can forward merge with the
    bad block range.
  - can_combine_front()
    Return 'true' if two adjacent bad block ranges before the
    manipulating range can be merged.
  - overlap_front()
    Return 'true' if the manipulating range exactly overlaps with the
    bad block range in front of its range.
  - overlap_behind()
    Return 'true' if the manipulating range exactly overlaps with the
    bad block range behind its range.
  - can_front_overwrite()
    Return 'true' if the manipulating range can forward overwrite the
    bad block range in front of its range.

- The following helpers are to add the manipulating range into the bad
  block table. Different routine is called with the specific relative
  layout between the manipulating range and other bad block range in the
  bad block table.
  - behind_merge()
    Merge the manipulating range with the bad block range behind its
    range, and return the number of merged length in unit of sector.
  - front_merge()
    Merge the manipulating range with the bad block range in front of
    its range, and return the number of merged length in unit of sector.
  - front_combine()
    Combine the two adjacent bad block ranges before the manipulating
    range into a larger one.
  - front_overwrite()
    Overwrite partial of whole bad block range which is in front of the
    manipulating range. The overwrite may split existing bad block range
    and generate more bad block ranges into the bad block table.
  - insert_at()
    Insert the manipulating range at a specific location in the bad
    block table.

All the above helpers are used in later patches to improve the bad block
ranges handling for badblocks_set()/badblocks_clear()/badblocks_check().

Signed-off-by: Coly Li <colyli@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Geliang Tang <geliang.tang@suse.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: NeilBrown <neilb@suse.de>
Cc: Vishal L Verma <vishal.l.verma@intel.com>
Cc: Xiao Ni <xni@redhat.com>
---
 block/badblocks.c | 386 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 386 insertions(+)

diff --git a/block/badblocks.c b/block/badblocks.c
index 3afb550c0f7b..7e7f9f14bb1d 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -16,6 +16,392 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 
+/*
+ * Find the range starts at-or-before 's' from bad table. The search
+ * starts from index 'hint' and stops at index 'hint_end' from the bad
+ * table.
+ */
+static int prev_by_hint(struct badblocks *bb, sector_t s, int hint)
+{
+	int hint_end = hint + 2;
+	u64 *p = bb->page;
+	int ret = -1;
+
+	while ((hint < hint_end) && ((hint + 1) <= bb->count) &&
+	       (BB_OFFSET(p[hint]) <= s)) {
+		if ((hint + 1) == bb->count || BB_OFFSET(p[hint + 1]) > s) {
+			ret = hint;
+			break;
+		}
+		hint++;
+	}
+
+	return ret;
+}
+
+/*
+ * Find the range starts at-or-before bad->start. If 'hint' is provided
+ * (hint >= 0) then search in the bad table from hint firstly. It is
+ * very probably the wanted bad range can be found from the hint index,
+ * then the unnecessary while-loop iteration can be avoided.
+ */
+static int prev_badblocks(struct badblocks *bb, struct badblocks_context *bad,
+			  int hint)
+{
+	sector_t s = bad->start;
+	int ret = -1;
+	int lo, hi;
+	u64 *p;
+
+	if (!bb->count)
+		goto out;
+
+	if (hint >= 0) {
+		ret = prev_by_hint(bb, s, hint);
+		if (ret >= 0)
+			goto out;
+	}
+
+	lo = 0;
+	hi = bb->count;
+	p = bb->page;
+
+	/* The following bisect search might be unnecessary */
+	if (BB_OFFSET(p[lo]) > s)
+		return -1;
+	if (BB_OFFSET(p[hi - 1]) <= s)
+		return hi - 1;
+
+	/* Do bisect search in bad table */
+	while (hi - lo > 1) {
+		int mid = (lo + hi)/2;
+		sector_t a = BB_OFFSET(p[mid]);
+
+		if (a == s) {
+			ret = mid;
+			goto out;
+		}
+
+		if (a < s)
+			lo = mid;
+		else
+			hi = mid;
+	}
+
+	if (BB_OFFSET(p[lo]) <= s)
+		ret = lo;
+out:
+	return ret;
+}
+
+/*
+ * Return 'true' if the range indicated by 'bad' can be backward merged
+ * with the bad range (from the bad table) index by 'behind'.
+ */
+static bool can_merge_behind(struct badblocks *bb,
+			     struct badblocks_context *bad, int behind)
+{
+	sector_t sectors = bad->len;
+	sector_t s = bad->start;
+	u64 *p = bb->page;
+
+	if ((s < BB_OFFSET(p[behind])) &&
+	    ((s + sectors) >= BB_OFFSET(p[behind])) &&
+	    ((BB_END(p[behind]) - s) <= BB_MAX_LEN) &&
+	    BB_ACK(p[behind]) == bad->ack)
+		return true;
+	return false;
+}
+
+/*
+ * Do backward merge for range indicated by 'bad' and the bad range
+ * (from the bad table) indexed by 'behind'. The return value is merged
+ * sectors from bad->len.
+ */
+static int behind_merge(struct badblocks *bb, struct badblocks_context *bad,
+			int behind)
+{
+	sector_t sectors = bad->len;
+	sector_t s = bad->start;
+	u64 *p = bb->page;
+	int merged = 0;
+
+	WARN_ON(s >= BB_OFFSET(p[behind]));
+	WARN_ON((s + sectors) < BB_OFFSET(p[behind]));
+
+	if (s < BB_OFFSET(p[behind])) {
+		merged = BB_OFFSET(p[behind]) - s;
+		p[behind] =  BB_MAKE(s, BB_LEN(p[behind]) + merged, bad->ack);
+
+		WARN_ON((BB_LEN(p[behind]) + merged) >= BB_MAX_LEN);
+	}
+
+	return merged;
+}
+
+/*
+ * Return 'true' if the range indicated by 'bad' can be forward
+ * merged with the bad range (from the bad table) indexed by 'prev'.
+ */
+static bool can_merge_front(struct badblocks *bb, int prev,
+			    struct badblocks_context *bad)
+{
+	sector_t s = bad->start;
+	u64 *p = bb->page;
+
+	if (BB_ACK(p[prev]) == bad->ack &&
+	    (s < BB_END(p[prev]) ||
+	     (s == BB_END(p[prev]) && (BB_LEN(p[prev]) < BB_MAX_LEN))))
+		return true;
+	return false;
+}
+
+/*
+ * Do forward merge for range indicated by 'bad' and the bad range
+ * (from bad table) indexed by 'prev'. The return value is sectors
+ * merged from bad->len.
+ */
+static int front_merge(struct badblocks *bb, int prev, struct badblocks_context *bad)
+{
+	sector_t sectors = bad->len;
+	sector_t s = bad->start;
+	u64 *p = bb->page;
+	int merged = 0;
+
+	WARN_ON(s > BB_END(p[prev]));
+
+	if (s < BB_END(p[prev])) {
+		merged = min_t(sector_t, sectors, BB_END(p[prev]) - s);
+	} else {
+		merged = min_t(sector_t, sectors, BB_MAX_LEN - BB_LEN(p[prev]));
+		if ((prev + 1) < bb->count &&
+		    merged > (BB_OFFSET(p[prev + 1]) - BB_END(p[prev]))) {
+			merged = BB_OFFSET(p[prev + 1]) - BB_END(p[prev]);
+		}
+
+		p[prev] = BB_MAKE(BB_OFFSET(p[prev]),
+				  BB_LEN(p[prev]) + merged, bad->ack);
+	}
+
+	return merged;
+}
+
+/*
+ * 'Combine' is a special case which can_merge_front() is not able to
+ * handle: If a bad range (indexed by 'prev' from bad table) exactly
+ * starts as bad->start, and the bad range ahead of 'prev' (indexed by
+ * 'prev - 1' from bad table) exactly ends at where 'prev' starts, and
+ * the sum of their lengths does not exceed BB_MAX_LEN limitation, then
+ * these two bad range (from bad table) can be combined.
+ *
+ * Return 'true' if bad ranges indexed by 'prev' and 'prev - 1' from bad
+ * table can be combined.
+ */
+static bool can_combine_front(struct badblocks *bb, int prev,
+			      struct badblocks_context *bad)
+{
+	u64 *p = bb->page;
+
+	if ((prev > 0) &&
+	    (BB_OFFSET(p[prev]) == bad->start) &&
+	    (BB_END(p[prev - 1]) == BB_OFFSET(p[prev])) &&
+	    (BB_LEN(p[prev - 1]) + BB_LEN(p[prev]) <= BB_MAX_LEN) &&
+	    (BB_ACK(p[prev - 1]) == BB_ACK(p[prev])))
+		return true;
+	return false;
+}
+
+/*
+ * Combine the bad ranges indexed by 'prev' and 'prev - 1' (from bad
+ * table) into one larger bad range, and the new range is indexed by
+ * 'prev - 1'.
+ * The caller of front_combine() will decrease bb->count, therefore
+ * it is unnecessary to clear p[perv] after front merge.
+ */
+static void front_combine(struct badblocks *bb, int prev)
+{
+	u64 *p = bb->page;
+
+	p[prev - 1] = BB_MAKE(BB_OFFSET(p[prev - 1]),
+			      BB_LEN(p[prev - 1]) + BB_LEN(p[prev]),
+			      BB_ACK(p[prev]));
+	if ((prev + 1) < bb->count)
+		memmove(p + prev, p + prev + 1, (bb->count - prev - 1) * 8);
+}
+
+/*
+ * Return 'true' if the range indicated by 'bad' is exactly forward
+ * overlapped with the bad range (from bad table) indexed by 'front'.
+ * Exactly forward overlap means the bad range (from bad table) indexed
+ * by 'prev' does not cover the whole range indicated by 'bad'.
+ */
+static bool overlap_front(struct badblocks *bb, int front,
+			  struct badblocks_context *bad)
+{
+	u64 *p = bb->page;
+
+	if (bad->start >= BB_OFFSET(p[front]) &&
+	    bad->start < BB_END(p[front]))
+		return true;
+	return false;
+}
+
+/*
+ * Return 'true' if the range indicated by 'bad' is exactly backward
+ * overlapped with the bad range (from bad table) indexed by 'behind'.
+ */
+static bool overlap_behind(struct badblocks *bb, struct badblocks_context *bad,
+			   int behind)
+{
+	u64 *p = bb->page;
+
+	if (bad->start < BB_OFFSET(p[behind]) &&
+	    (bad->start + bad->len) > BB_OFFSET(p[behind]))
+		return true;
+	return false;
+}
+
+/*
+ * Return 'true' if the range indicated by 'bad' can overwrite the bad
+ * range (from bad table) indexed by 'prev'.
+ *
+ * The range indicated by 'bad' can overwrite the bad range indexed by
+ * 'prev' when,
+ * 1) The whole range indicated by 'bad' can cover partial or whole bad
+ *    range (from bad table) indexed by 'prev'.
+ * 2) The ack value of 'bad' is larger or equal to the ack value of bad
+ *    range 'prev'.
+ *
+ * If the overwriting doesn't cover the whole bad range (from bad table)
+ * indexed by 'prev', new range might be split from existing bad range,
+ * 1) The overwrite covers head or tail part of existing bad range, 1
+ *    extra bad range will be split and added into the bad table.
+ * 2) The overwrite covers middle of existing bad range, 2 extra bad
+ *    ranges will be split (ahead and after the overwritten range) and
+ *    added into the bad table.
+ * The number of extra split ranges of the overwriting is stored in
+ * 'extra' and returned for the caller.
+ */
+static bool can_front_overwrite(struct badblocks *bb, int prev,
+				struct badblocks_context *bad, int *extra)
+{
+	u64 *p = bb->page;
+	int len;
+
+	WARN_ON(!overlap_front(bb, prev, bad));
+
+	if (BB_ACK(p[prev]) >= bad->ack)
+		return false;
+
+	if (BB_END(p[prev]) <= (bad->start + bad->len)) {
+		len = BB_END(p[prev]) - bad->start;
+		if (BB_OFFSET(p[prev]) == bad->start)
+			*extra = 0;
+		else
+			*extra = 1;
+
+		bad->len = len;
+	} else {
+		if (BB_OFFSET(p[prev]) == bad->start)
+			*extra = 1;
+		else
+		/*
+		 * prev range will be split into two, beside the overwritten
+		 * one, an extra slot needed from bad table.
+		 */
+			*extra = 2;
+	}
+
+	if ((bb->count + (*extra)) >= MAX_BADBLOCKS)
+		return false;
+
+	return true;
+}
+
+/*
+ * Do the overwrite from the range indicated by 'bad' to the bad range
+ * (from bad table) indexed by 'prev'.
+ * The previously called can_front_overwrite() will provide how many
+ * extra bad range(s) might be split and added into the bad table. All
+ * the splitting cases in the bad table will be handled here.
+ */
+static int front_overwrite(struct badblocks *bb, int prev,
+			   struct badblocks_context *bad, int extra)
+{
+	u64 *p = bb->page;
+	sector_t orig_end = BB_END(p[prev]);
+	int orig_ack = BB_ACK(p[prev]);
+
+	switch (extra) {
+	case 0:
+		p[prev] = BB_MAKE(BB_OFFSET(p[prev]), BB_LEN(p[prev]),
+				  bad->ack);
+		break;
+	case 1:
+		if (BB_OFFSET(p[prev]) == bad->start) {
+			p[prev] = BB_MAKE(BB_OFFSET(p[prev]),
+					  bad->len, bad->ack);
+			memmove(p + prev + 2, p + prev + 1,
+				(bb->count - prev - 1) * 8);
+			p[prev + 1] = BB_MAKE(bad->start + bad->len,
+					      orig_end - BB_END(p[prev]),
+					      orig_ack);
+		} else {
+			p[prev] = BB_MAKE(BB_OFFSET(p[prev]),
+					  bad->start - BB_OFFSET(p[prev]),
+					  orig_ack);
+			/*
+			 * prev +2 -> prev + 1 + 1, which is for,
+			 * 1) prev + 1: the slot index of the previous one
+			 * 2) + 1: one more slot for extra being 1.
+			 */
+			memmove(p + prev + 2, p + prev + 1,
+				(bb->count - prev - 1) * 8);
+			p[prev + 1] = BB_MAKE(bad->start, bad->len, bad->ack);
+		}
+		break;
+	case 2:
+		p[prev] = BB_MAKE(BB_OFFSET(p[prev]),
+				  bad->start - BB_OFFSET(p[prev]),
+				  orig_ack);
+		/*
+		 * prev + 3 -> prev + 1 + 2, which is for,
+		 * 1) prev + 1: the slot index of the previous one
+		 * 2) + 2: two more slots for extra being 2.
+		 */
+		memmove(p + prev + 3, p + prev + 1,
+			(bb->count - prev - 1) * 8);
+		p[prev + 1] = BB_MAKE(bad->start, bad->len, bad->ack);
+		p[prev + 2] = BB_MAKE(BB_END(p[prev + 1]),
+				      orig_end - BB_END(p[prev + 1]),
+				      orig_ack);
+		break;
+	default:
+		break;
+	}
+
+	return bad->len;
+}
+
+/*
+ * Explicitly insert a range indicated by 'bad' to the bad table, where
+ * the location is indexed by 'at'.
+ */
+static int insert_at(struct badblocks *bb, int at, struct badblocks_context *bad)
+{
+	u64 *p = bb->page;
+	int len;
+
+	WARN_ON(badblocks_full(bb));
+
+	len = min_t(sector_t, bad->len, BB_MAX_LEN);
+	if (at < bb->count)
+		memmove(p + at + 1, p + at, (bb->count - at) * 8);
+	p[at] = BB_MAKE(bad->start, len, bad->ack);
+
+	return len;
+}
+
 /**
  * badblocks_check() - check a given range for bad sectors
  * @bb:		the badblocks structure that holds all badblock information
-- 
2.35.3

