Return-Path: <linux-raid+bounces-2640-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2F596164E
	for <lists+linux-raid@lfdr.de>; Tue, 27 Aug 2024 20:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 002DA28848C
	for <lists+linux-raid@lfdr.de>; Tue, 27 Aug 2024 18:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510931D416D;
	Tue, 27 Aug 2024 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oj7N8snw"
X-Original-To: linux-raid@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663981D2F47
	for <linux-raid@vger.kernel.org>; Tue, 27 Aug 2024 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724781810; cv=none; b=UJWeGS9XBYyvuEwtmBZi1FxUhwIaYtnBUVxsCSQk7RU7a34IT9ArxR5UXhcw0++H/qqesZBxUBp1tZYmWNTlWMx2FoE99bG/0F2H4HKyLc8Ts5jXlbZjdelTF1i6qh3MO6gULLkL8JF11ivfgJ3iaMq563qAA/YeNCKwVlWx9O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724781810; c=relaxed/simple;
	bh=vRZxlA4NhcmLd0q6bUaelJnaLNQfejDBlwC1tsp+b8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=reaZhDPvXc+XxQa7ag5ufkjJzF7XxZRKp48mMFo0H92O94log5oYfef79vQ1sAWw/a7euB1/HSwQGZK1ZKxnpj3a8bUjE2e7cjTVm59ThE4LmxMcp0OgAUgJdLyZPNsgfOCW3muuHSpNr13BEUzn6KjOH815IVGpmjNeaIzq36E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oj7N8snw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724781807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LykJQUiuG045SO6zmRnu8bef9DxxtsLHq0x3Z+ewaXo=;
	b=Oj7N8snw5BXRgDtK0eAjMOEKZOH8GhCj3Y2udMGFWDN4Ixn3qcOzgz4IRbEX+qVPTt2fo9
	Dt3s38b6r1xqtPCUafQztZ/BUX+7H92nvnlT+wrc4EOAjPLDPavDRS7CnhJL1Pe9flI4n5
	vx+xJVvymSDfT44r4YL2JUoJu/6z55o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433--ayIjcuCPze9ryjYvQt7vA-1; Tue,
 27 Aug 2024 14:03:24 -0400
X-MC-Unique: -ayIjcuCPze9ryjYvQt7vA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C75D11955D4F;
	Tue, 27 Aug 2024 18:03:21 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C8861955F1B;
	Tue, 27 Aug 2024 18:03:18 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	song@kernel.org,
	yukuai3@huawei.com,
	agruenba@redhat.com,
	mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	netdev@vger.kernel.org,
	vvidic@valentin-vidic.from.hr,
	heming.zhao@suse.com,
	lucien.xin@gmail.com,
	paulmck@kernel.org,
	rcu@vger.kernel.org,
	juri.lelli@redhat.com,
	williams@redhat.com,
	aahringo@redhat.com
Subject: [RFC 6/7] dlm: add more tracepoints for DLM kernel verifier
Date: Tue, 27 Aug 2024 14:02:35 -0400
Message-ID: <20240827180236.316946-7-aahringo@redhat.com>
In-Reply-To: <20240827180236.316946-1-aahringo@redhat.com>
References: <20240827180236.316946-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

This patch adds more useful tracepoints for the kernel verifier. The
lock/unlock validation tracepoints are useful to store the request state
mode that the lock must change to, at this time the lock request cannot
fail anymore. (It can fail but there might be upcoming changes because
we can't deal with that e.g. -ENOMEM cases).

Another tracepoint is dlm_release_lockspace() that signals us that a
node is leaving the lockspace and all locks holding should be dropped.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c              | 10 +++--
 fs/dlm/lockspace.c         |  4 ++
 include/trace/events/dlm.h | 80 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+), 3 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 21bb9603a0df..597418cba76a 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -2811,7 +2811,8 @@ static int set_unlock_args(uint32_t flags, void *astarg, struct dlm_args *args)
 }
 
 static int validate_lock_args(struct dlm_ls *ls, struct dlm_lkb *lkb,
-			      struct dlm_args *args)
+			      struct dlm_args *args, const char *res_name,
+			      size_t res_length)
 {
 	int rv = -EBUSY;
 
@@ -2845,6 +2846,7 @@ static int validate_lock_args(struct dlm_ls *ls, struct dlm_lkb *lkb,
 	lkb->lkb_lvbptr = args->lksb->sb_lvbptr;
 	lkb->lkb_ownpid = (int) current->pid;
 	lkb->lkb_rv_mode = args->mode;
+	trace_dlm_lock_validated(ls, lkb, args, res_name, res_length);
 	rv = 0;
  out:
 	switch (rv) {
@@ -2988,6 +2990,7 @@ static int validate_unlock_args(struct dlm_lkb *lkb, struct dlm_args *args)
 	lkb->lkb_exflags |= args->flags;
 	dlm_set_sbflags_val(lkb, 0);
 	lkb->lkb_astparam = args->astparam;
+	trace_dlm_unlock_validated(ls, lkb, args);
 	rv = 0;
  out:
 	switch (rv) {
@@ -3264,7 +3267,7 @@ static int request_lock(struct dlm_ls *ls, struct dlm_lkb *lkb,
 	struct dlm_rsb *r;
 	int error;
 
-	error = validate_lock_args(ls, lkb, args);
+	error = validate_lock_args(ls, lkb, args, name, len);
 	if (error)
 		return error;
 
@@ -3295,7 +3298,8 @@ static int convert_lock(struct dlm_ls *ls, struct dlm_lkb *lkb,
 	hold_rsb(r);
 	lock_rsb(r);
 
-	error = validate_lock_args(ls, lkb, args);
+	error = validate_lock_args(ls, lkb, args, r->res_name,
+				   r->res_length);
 	if (error)
 		goto out;
 
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 092f7017b896..c19d797264c5 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -9,6 +9,8 @@
 *******************************************************************************
 ******************************************************************************/
 
+#include <trace/events/dlm.h>
+
 #include <linux/netdevice.h>
 #include <linux/module.h>
 
@@ -781,6 +783,8 @@ static int release_lockspace(struct dlm_net *dn, struct dlm_ls *ls, int force)
 		return rv;
 	}
 
+	trace_dlm_release_lockspace(dn->our_node->id, ls->ls_global_id);
+
 	if (dn->ls_count == 1)
 		dlm_midcomms_version_wait(ls->ls_dn);
 
diff --git a/include/trace/events/dlm.h b/include/trace/events/dlm.h
index f8d7ca451760..facad6251e43 100644
--- a/include/trace/events/dlm.h
+++ b/include/trace/events/dlm.h
@@ -338,6 +338,86 @@ TRACE_EVENT(dlm_unlock_end,
 
 );
 
+TRACE_EVENT(dlm_release_lockspace,
+
+	TP_PROTO(unsigned int our_nodeid, __u32 ls_id),
+
+	TP_ARGS(our_nodeid, ls_id),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, our_nodeid)
+		__field(__u32, ls_id)
+	),
+
+	TP_fast_assign(
+		__entry->our_nodeid = our_nodeid;
+		__entry->ls_id = ls_id;
+	),
+
+	TP_printk("our_nodeid=%u ls_id=%u",
+		  __entry->our_nodeid, __entry->ls_id)
+
+);
+
+TRACE_EVENT(dlm_lock_validated,
+
+	TP_PROTO(struct dlm_ls *ls, struct dlm_lkb *lkb, struct dlm_args *args,
+		 const char *res_name, size_t res_length),
+
+	TP_ARGS(ls, lkb, args, res_name, res_length),
+
+	TP_STRUCT__entry(
+		__field(uint32_t, our_nodeid)
+		__field(uint32_t, ls_id)
+		__dynamic_array(unsigned char, res_name, res_length)
+		__field(int, mode)
+	),
+
+	TP_fast_assign(
+		__entry->our_nodeid = ls->ls_dn->our_node->id;
+		__entry->ls_id = ls->ls_global_id;
+		memcpy(__get_dynamic_array(res_name), res_name,
+		       __get_dynamic_array_len(res_name));
+		__entry->mode = args->mode;
+	),
+
+	TP_printk("our_nodeid=%u ls_id=%u res_name=%s mode=%d",
+		  __entry->our_nodeid, __entry->ls_id,
+		  __print_hex_str(__get_dynamic_array(res_name),
+				  __get_dynamic_array_len(res_name)),
+		  __entry->mode)
+
+);
+
+TRACE_EVENT(dlm_unlock_validated,
+
+	TP_PROTO(struct dlm_ls *ls, struct dlm_lkb *lkb, struct dlm_args *args),
+
+	TP_ARGS(ls, lkb, args),
+
+	TP_STRUCT__entry(
+		__field(uint32_t, our_nodeid)
+		__field(uint32_t, ls_id)
+		__dynamic_array(unsigned char, res_name,
+				lkb->lkb_resource->res_length)
+	),
+
+	TP_fast_assign(
+		struct dlm_rsb *r = lkb->lkb_resource;
+
+		__entry->our_nodeid = ls->ls_dn->our_node->id;
+		__entry->ls_id = ls->ls_global_id;
+		memcpy(__get_dynamic_array(res_name), r->res_name,
+		       __get_dynamic_array_len(res_name));
+	),
+
+	TP_printk("our_nodeid=%u ls_id=%u res_name=%s",
+		  __entry->our_nodeid, __entry->ls_id,
+		  __print_hex_str(__get_dynamic_array(res_name),
+				  __get_dynamic_array_len(res_name)))
+
+);
+
 DECLARE_EVENT_CLASS(dlm_rcom_template,
 
 	TP_PROTO(uint32_t dst, uint32_t h_seq, const struct dlm_rcom *rc),
-- 
2.43.0


