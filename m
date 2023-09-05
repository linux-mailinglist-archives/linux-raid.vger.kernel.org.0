Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A327927CC
	for <lists+linux-raid@lfdr.de>; Tue,  5 Sep 2023 18:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbjIEQDp (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 5 Sep 2023 12:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354856AbjIEPHT (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 5 Sep 2023 11:07:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0B818D
        for <linux-raid@vger.kernel.org>; Tue,  5 Sep 2023 08:07:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D367221BF4;
        Tue,  5 Sep 2023 15:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693926433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aYBioI7hDw6gZmrpEGH9M6jXBsJjL4gB/otP/tCbPcs=;
        b=FRXejz7AcTaXSMSAf2cf1TfiTolBmJTliCnDVtNo2HFNFL6jK1PDPCnL4YBeROiNW4vg8a
        YnKetBBVl32/b20zNWdOdwRm3lA5aCucjvtkn3WH7sxkOb/l65pflM3oBgeCQE/Dh2cJ+N
        wv/CAzdS1xkcMcCVgYtSOEroGrTt+Iw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9860D13911;
        Tue,  5 Sep 2023 15:07:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aYWaIyFE92TbbgAAMHmgww
        (envelope-from <mwilck@suse.com>); Tue, 05 Sep 2023 15:07:13 +0000
Message-ID: <f22989f511b55e200f63a27ff60d14951bfb139c.camel@suse.com>
Subject: Re: [PATCH v2] Fix race of "mdadm --add" and "mdadm --incremental"
From:   Martin Wilck <mwilck@suse.com>
To:     Li Xiao Keng <lixiaokeng@huawei.com>,
        Jes Sorensen <jes@trained-monkey.org>,
        Coly Li <colyli@suse.de>, linux-raid@vger.kernel.org
Cc:     louhongxiang@huawei.com, miaoguanqin <miaoguanqin@huawei.com>
Date:   Tue, 05 Sep 2023 17:07:12 +0200
In-Reply-To: <bcc2d161-521b-ea19-b090-9822925645e5@huawei.com>
References: <bcc2d161-521b-ea19-b090-9822925645e5@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

T24gVHVlLCAyMDIzLTA5LTA1IGF0IDIwOjAyICswODAwLCBMaSBYaWFvIEtlbmcgd3JvdGU6Cj4g
V2hlbiB3ZSBhZGQgYSBuZXcgZGlzayB0byBhIHJhaWQsIGl0IG1heSByZXR1cm4gLUVCVVNZLgo+
IAo+IFRoZSBtYWluIHByb2Nlc3Mgb2YgLS1hZGQ6Cj4gMS4gZGV2X29wZW4KPiAyLiBzdG9yZV9z
dXBlcjEoc3QsIGRpLT5mZCkgaW4gd3JpdGVfaW5pdF9zdXBlcjEKPiAzLiBmc3luYyhkaS0+ZmQp
IGluIHdyaXRlX2luaXRfc3VwZXIxCj4gNC4gY2xvc2UoZGktPmZkKQo+IDUuIGlvY3RsKEFERF9O
RVdfRElTSykKPiAKPiBIb3dldmVyLCB0aGVyZSB3aWxsIGJlIHNvbWUgdWRldihjaGFuZ2UpIGV2
ZW50IGFmdGVyIHN0ZXA0LiBUaGVuCj4gIi91c3Ivc2Jpbi9tZGFkbSAtLWluY3JlbWVudGFsIC4u
LiIgd2lsbCBiZSBydW4sIGFuZCB0aGUgbmV3IGRpc2sKPiB3aWxsIGJlIGFkZCB0byBtZCBkZXZp
Y2UuIEFmdGVyIHRoYXQsIGlvY3RsIHdpbGwgcmV0dXJuIC1FQlVTWS4KPiAKPiBIZXJlIHdlIGFk
ZCBtYXBfbG9jayBiZWZvcmUgd3JpdGVfaW5pdF9zdXBlciBpbiAibWRhZG0gLS1hZGQiCj4gdG8g
Zml4IHRoaXMgcmFjZS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBMaSBYaWFvIEtlbmcgPGxpeGlhb2tl
bmdAaHVhd2VpLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBHdWFucWluIE1pYW8gPG1pYW9ndWFucWlu
QGh1YXdlaS5jb20+CgpSZXZpZXdlZC1ieTogTWFydGluIFdpbGNrIDxtd2lsY2tAc3VzZS5jb20+
Cgo+IC0tLQo+IKBBc3NlbWJsZS5jIHygIDUgKysrKy0KPiCgTWFuYWdlLmOgoCB8IDI1ICsrKysr
KysrKysrKysrKysrLS0tLS0tLS0KPiCgMiBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCsp
LCA5IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9Bc3NlbWJsZS5jIGIvQXNzZW1ibGUu
Ywo+IGluZGV4IDQ5ODA0OTQxLi4wODY4OTBlZCAxMDA2NDQKPiAtLS0gYS9Bc3NlbWJsZS5jCj4g
KysrIGIvQXNzZW1ibGUuYwo+IEBAIC0xNDc5LDggKzE0NzksMTEgQEAgdHJ5X2FnYWluOgo+IKCg
oKCgoKCgICogdG8gb3VyIGxpc3QuoCBXZSBmbGFnIHRoZW0gc28gdGhhdCB3ZSBkb24ndCB0cnkg
dG8gcmUtYWRkLAo+IKCgoKCgoKCgICogYnV0IGNhbiByZW1vdmUgaWYgdGhleSB0dXJuIG91dCB0
byBub3QgYmUgd2FudGVkLgo+IKCgoKCgoKCgICovCj4gLaCgoKCgoKBpZiAobWFwX2xvY2soJm1h
cCkpCj4gK6CgoKCgoKBpZiAobWFwX2xvY2soJm1hcCkpIHsKPiCgoKCgoKCgoKCgoKCgoKCgcHJf
ZXJyKCJmYWlsZWQgdG8gZ2V0IGV4Y2x1c2l2ZSBsb2NrIG9uIG1hcGZpbGUgLQo+IGNvbnRpbnVl
IGFueXdheS4uLlxuIik7Cj4gK6CgoKCgoKCgoKCgoKCgoHJldHVybiAxOwo+ICugoKCgoKCgfQo+
ICsKPiCgoKCgoKCgoGlmIChjLT51cGRhdGUgPT0gVU9QVF9VVUlEKQo+IKCgoKCgoKCgoKCgoKCg
oKBtcCA9IE5VTEw7Cj4goKCgoKCgoKBlbHNlCj4gZGlmZiAtLWdpdCBhL01hbmFnZS5jIGIvTWFu
YWdlLmMKPiBpbmRleCBmNTRkZTdjNi4uNmExMDFiYWUgMTAwNjQ0Cj4gLS0tIGEvTWFuYWdlLmMK
PiArKysgYi9NYW5hZ2UuYwo+IEBAIC03MDMsNiArNzAzLDcgQEAgaW50IE1hbmFnZV9hZGQoaW50
IGZkLCBpbnQgdGZkLCBzdHJ1Y3QgbWRkZXZfZGV2Cj4gKmR2LAo+IKCgoKCgoKCgc3RydWN0IHN1
cGVydHlwZSAqZGV2X3N0Owo+IKCgoKCgoKCgaW50IGo7Cj4goKCgoKCgoKBtZHVfZGlza19pbmZv
X3QgZGlzYzsKPiAroKCgoKCgoHN0cnVjdCBtYXBfZW50ICptYXAgPSBOVUxMOwo+IAo+IKCgoKCg
oKCgaWYgKCFnZXRfZGV2X3NpemUodGZkLCBkdi0+ZGV2bmFtZSwgJmxkc2l6ZSkpIHsKPiCgoKCg
oKCgoKCgoKCgoKCgaWYgKGR2LT5kaXNwb3NpdGlvbiA9PSAnTScpCj4gQEAgLTkwMCw2ICs5MDEs
MTAgQEAgaW50IE1hbmFnZV9hZGQoaW50IGZkLCBpbnQgdGZkLCBzdHJ1Y3QgbWRkZXZfZGV2Cj4g
KmR2LAo+IKCgoKCgoKCgoKCgoKCgoKBkaXNjLnJhaWRfZGlzayA9IDA7Cj4goKCgoKCgoKB9Cj4g
Cj4gK6CgoKCgoKBpZiAobWFwX2xvY2soJm1hcCkpIHsKPiAroKCgoKCgoKCgoKCgoKCgcHJfZXJy
KCJmYWlsZWQgdG8gZ2V0IGV4Y2x1c2l2ZSBsb2NrIG9uIG1hcGZpbGUgd2hlbgo+IGFkZCBkaXNr
XG4iKTsKPiAroKCgoKCgoKCgoKCgoKCgcmV0dXJuIC0xOwo+ICugoKCgoKCgfQo+IKCgoKCgoKCg
aWYgKGFycmF5LT5ub3RfcGVyc2lzdGVudD09MCkgewo+IKCgoKCgoKCgoKCgoKCgoKBpbnQgZGZk
Owo+IKCgoKCgoKCgoKCgoKCgoKBpZiAoZHYtPmRpc3Bvc2l0aW9uID09ICdqJykKPiBAQCAtOTEx
LDkgKzkxNiw5IEBAIGludCBNYW5hZ2VfYWRkKGludCBmZCwgaW50IHRmZCwgc3RydWN0IG1kZGV2
X2Rldgo+ICpkdiwKPiCgoKCgoKCgoKCgoKCgoKCgZGZkID0gZGV2X29wZW4oZHYtPmRldm5hbWUs
IE9fUkRXUiB8Cj4gT19FWENMfE9fRElSRUNUKTsKPiCgoKCgoKCgoKCgoKCgoKCgaWYgKHRzdC0+
c3MtPmFkZF90b19zdXBlcih0c3QsICZkaXNjLCBkZmQsCj4goKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKAgZHYtPmRldm5hbWUsCj4gSU5WQUxJRF9TRUNUT1JTKSkKPiAt
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKByZXR1cm4gLTE7Cj4gK6CgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgZ290byB1bmxvY2s7Cj4goKCgoKCgoKCgoKCgoKCgoGlmICh0c3QtPnNzLT53cml0ZV9pbml0
X3N1cGVyKHRzdCkpCj4gLaCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgcmV0dXJuIC0xOwo+ICugoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoGdvdG8gdW5sb2NrOwo+IKCgoKCgoKCgfSBlbHNlIGlmIChkdi0+
ZGlzcG9zaXRpb24gPT0gJ0EnKSB7Cj4goKCgoKCgoKCgoKCgoKCgoC8qoCB0aGlzIGhhZCBiZXR0
ZXIgYmUgcmFpZDEuCj4goKCgoKCgoKCgoKCgoKCgoCAqIEFzIHdlIGFyZSAiLS1yZS1hZGQiaW5n
IHdlIG11c3QgZmluZCBhIHNwYXJlIHNsb3QKPiBAQCAtOTcxLDE0ICs5NzYsMTQgQEAgaW50IE1h
bmFnZV9hZGQoaW50IGZkLCBpbnQgdGZkLCBzdHJ1Y3QKPiBtZGRldl9kZXYgKmR2LAo+IKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoHByX2VycigiYWRkIGZhaWxlZCBmb3IgJXM6IGNvdWxkIG5vdCBn
ZXQKPiBleGNsdXNpdmUgYWNjZXNzIHRvIGNvbnRhaW5lclxuIiwKPiCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKAgZHYtPmRldm5hbWUpOwo+IKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoHRz
dC0+c3MtPmZyZWVfc3VwZXIodHN0KTsKPiAtoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKByZXR1cm4g
LTE7Cj4gK6CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgZ290byB1bmxvY2s7Cj4goKCgoKCgoKCgoKCg
oKCgoH0KPiAKPiCgoKCgoKCgoKCgoKCgoKCgLyogQ2hlY2sgaWYgbWV0YWRhdGEgaGFuZGxlciBp
cyBhYmxlIHRvIGFjY2VwdCB0aGUKPiBkcml2ZSAqLwo+IKCgoKCgoKCgoKCgoKCgoKBpZiAoIXRz
dC0+c3MtPnZhbGlkYXRlX2dlb21ldHJ5KHRzdCwgTEVWRUxfQ09OVEFJTkVSLAo+IDAsIDEsIE5V
TEwsCj4goKCgoKCgoKCgoKCgoKCgoKCgoCAwLCAwLCBkdi0+ZGV2bmFtZSwgTlVMTCwgMCwgMSkp
IHsKPiCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBjbG9zZShjb250YWluZXJfZmQpOwo+IC2goKCg
oKCgoKCgoKCgoKCgoKCgoKCgoHJldHVybiAtMTsKPiAroKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBn
b3RvIHVubG9jazsKPiCgoKCgoKCgoKCgoKCgoKCgfQo+IAo+IKCgoKCgoKCgoKCgoKCgoKBLaWxs
KGR2LT5kZXZuYW1lLCBOVUxMLCAwLCAtMSwgMCk7Cj4gQEAgLTk4Nyw3ICs5OTIsNyBAQCBpbnQg
TWFuYWdlX2FkZChpbnQgZmQsIGludCB0ZmQsIHN0cnVjdCBtZGRldl9kZXYKPiAqZHYsCj4goKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgZHYtPmRldm5hbWUsCj4gSU5W
QUxJRF9TRUNUT1JTKSkgewo+IKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGNsb3NlKGRmZCk7Cj4g
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgY2xvc2UoY29udGFpbmVyX2ZkKTsKPiAtoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKByZXR1cm4gLTE7Cj4gK6CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgZ290byB1
bmxvY2s7Cj4goKCgoKCgoKCgoKCgoKCgoH0KPiCgoKCgoKCgoKCgoKCgoKCgaWYgKCFtZG1vbl9y
dW5uaW5nKHRzdC0+Y29udGFpbmVyX2Rldm5tKSkKPiCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKB0
c3QtPnNzLT5zeW5jX21ldGFkYXRhKHRzdCk7Cj4gQEAgLTk5OCw3ICsxMDAzLDcgQEAgaW50IE1h
bmFnZV9hZGQoaW50IGZkLCBpbnQgdGZkLCBzdHJ1Y3QgbWRkZXZfZGV2Cj4gKmR2LAo+IKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCBkdi0+ZGV2bmFtZSk7Cj4goKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgY2xvc2UoY29udGFpbmVyX2ZkKTsKPiCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKB0
c3QtPnNzLT5mcmVlX3N1cGVyKHRzdCk7Cj4gLaCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgcmV0dXJu
IC0xOwo+ICugoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGdvdG8gdW5sb2NrOwo+IKCgoKCgoKCgoKCg
oKCgoKB9Cj4goKCgoKCgoKCgoKCgoKCgoHNyYS0+YXJyYXkubGV2ZWwgPSBMRVZFTF9DT05UQUlO
RVI7Cj4goKCgoKCgoKCgoKCgoKCgoC8qIE5lZWQgdG8gc2V0IGRhdGFfb2Zmc2V0IGFuZCBjb21w
b25lbnRfc2l6ZSAqLwo+IEBAIC0xMDEzLDcgKzEwMTgsNyBAQCBpbnQgTWFuYWdlX2FkZChpbnQg
ZmQsIGludCB0ZmQsIHN0cnVjdAo+IG1kZGV2X2RldiAqZHYsCj4goKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgcHJfZXJyKCJhZGQgbmV3IGRldmljZSB0byBleHRlcm5hbCBtZXRhZGF0YQo+IGZhaWxl
ZCBmb3IgJXNcbiIsIGR2LT5kZXZuYW1lKTsKPiCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBjbG9z
ZShjb250YWluZXJfZmQpOwo+IKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoHN5c2ZzX2ZyZWUoc3Jh
KTsKPiAtoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKByZXR1cm4gLTE7Cj4gK6CgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgZ290byB1bmxvY2s7Cj4goKCgoKCgoKCgoKCgoKCgoH0KPiCgoKCgoKCgoKCgoKCg
oKCgcGluZ19tb25pdG9yKGRldm5tKTsKPiCgoKCgoKCgoKCgoKCgoKCgc3lzZnNfZnJlZShzcmEp
Owo+IEBAIC0xMDI3LDcgKzEwMzIsNyBAQCBpbnQgTWFuYWdlX2FkZChpbnQgZmQsIGludCB0ZmQs
IHN0cnVjdAo+IG1kZGV2X2RldiAqZHYsCj4goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgZWxzZQo+
IKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgcHJfZXJyKCJhZGQgbmV3IGRldmljZSBm
YWlsZWQgZm9yICVzCj4gYXMgJWQ6ICVzXG4iLAo+IKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgIGR2LT5kZXZuYW1lLCBqLAo+IHN0cmVycm9yKGVycm5vKSk7Cj4gLaCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgcmV0dXJuIC0xOwo+ICugoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGdv
dG8gdW5sb2NrOwo+IKCgoKCgoKCgoKCgoKCgoKB9Cj4goKCgoKCgoKCgoKCgoKCgoGlmIChkdi0+
ZGlzcG9zaXRpb24gPT0gJ2onKSB7Cj4goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgcHJfZXJyKCJK
b3VybmFsIGFkZGVkIHN1Y2Nlc3NmdWxseSwgbWFraW5nICVzCj4gcmVhZC13cml0ZVxuIiwgZGV2
bmFtZSk7Cj4gQEAgLTEwMzgsNyArMTA0MywxMSBAQCBpbnQgTWFuYWdlX2FkZChpbnQgZmQsIGlu
dCB0ZmQsIHN0cnVjdAo+IG1kZGV2X2RldiAqZHYsCj4goKCgoKCgoKB9Cj4goKCgoKCgoKBpZiAo
dmVyYm9zZSA+PSAwKQo+IKCgoKCgoKCgoKCgoKCgoKBwcl9lcnIoImFkZGVkICVzXG4iLCBkdi0+
ZGV2bmFtZSk7Cj4gK6CgoKCgoKBtYXBfdW5sb2NrKCZtYXApOwo+IKCgoKCgoKCgcmV0dXJuIDE7
Cj4gK3VubG9jazoKPiAroKCgoKCgoG1hcF91bmxvY2soJm1hcCk7Cj4gK6CgoKCgoKByZXR1cm4g
LTE7Cj4goH0KPiAKPiCgaW50IE1hbmFnZV9yZW1vdmUoc3RydWN0IHN1cGVydHlwZSAqdHN0LCBp
bnQgZmQsIHN0cnVjdCBtZGRldl9kZXYKPiAqZHYsCgo=

