Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44385201F08
	for <lists+linux-raid@lfdr.de>; Sat, 20 Jun 2020 02:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbgFTAOY (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 19 Jun 2020 20:14:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730663AbgFTAOX (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 19 Jun 2020 20:14:23 -0400
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3976D2256E
        for <linux-raid@vger.kernel.org>; Sat, 20 Jun 2020 00:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592612061;
        bh=EPb/HSdWgk+GOxSd4SxLTTjeOSnWP+4tm5TXcT2L4WY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u66onLpMy6Gw5QkSCwjo2V22h0pW4dtQSfam8W67ctfarKkig92i0md8X/FAg/szC
         fb/u4r3Ktu+Qnbjm84+OCKdOa9F1XlDMoMmyrbQR4BfSx55Hc1owGIaz3k/AbQCE2O
         R9Ko5ACMF/uSQ/NSXPRey7fArGQ5VfGAbOYNVLAk=
Received: by mail-lj1-f179.google.com with SMTP id z9so13365033ljh.13
        for <linux-raid@vger.kernel.org>; Fri, 19 Jun 2020 17:14:21 -0700 (PDT)
X-Gm-Message-State: AOAM531xLJ+M9KfK1oOoK0keHvGkxQr38LAcAAsAcHXi62dDogTWyN0B
        vv2oDKhlO3UpfqK48o1VcSwn2lTvuK9LPy57K14=
X-Google-Smtp-Source: ABdhPJz4xs8f+hhZyBmOq8bYEblqFjyB1hMaAt6H9PtB+gkLCz3MESyR++GmBtRq0OGLekA+ak+jtayQnMawpA9Vpp8=
X-Received: by 2002:a2e:7313:: with SMTP id o19mr3026174ljc.27.1592612059456;
 Fri, 19 Jun 2020 17:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <f8c61278-1758-66cd-cf25-8a118cb12f58@yandex.pl>
 <7b2b2bca-c1b7-06c5-10c5-2b1cdda21607@yandex.pl> <48e4fa28-4d20-ba80-cd69-b17da719531a@yandex.pl>
 <CAPhsuW69VYgLBZboxvQ6-Fmm-Oa0fGOVBg3SOVkzP_UopH+_wg@mail.gmail.com>
 <1767d7aa-6c60-7efb-bf37-6506f9aaa8a2@yandex.pl> <CAPhsuW4oMKuCrHUU1ucsMKQbSfBQdsNEQWHA1SSbGR5nbvy21w@mail.gmail.com>
 <CAPhsuW4WBDGGLYc=f4xoThxtxuF5K74m3odJ-uA98DuPLJR4nw@mail.gmail.com>
 <0cf6454d-a8b5-4bee-5389-94b23c077050@yandex.pl> <CAPhsuW51u6KWLvUntMXPU7stu7oSA+d-yT6zf7G0zCETzLWwiA@mail.gmail.com>
 <49efa0d2-b44c-ec85-5e44-fb93a15001e7@yandex.pl> <4df42e3d-ad2b-dfc2-3961-49ada4ea7eaf@yandex.pl>
 <CAPhsuW5kk0G9PSfEADc8+rn=QT2z4ogjuV98qWsH_s_WBic-5w@mail.gmail.com>
 <71f58507-314e-4a1d-dd50-41a60d76521b@yandex.pl> <CAPhsuW59Q7mU9WH36RHs9kb-TMk7FmrQL+JCApupf_TZtpWynA@mail.gmail.com>
 <4a03e900-61a8-f150-9be8-739e88ba8ce6@yandex.pl> <CAPhsuW4BZE-DeESsq-coNx5_KZrfHjP=d9YOjOPqPji5kQBXjg@mail.gmail.com>
 <a772ede5-1d6f-e7cd-e949-a5d81d0fdbd1@yandex.pl>
In-Reply-To: <a772ede5-1d6f-e7cd-e949-a5d81d0fdbd1@yandex.pl>
From:   Song Liu <song@kernel.org>
Date:   Fri, 19 Jun 2020 17:14:07 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5hwAMTy8ozpsT+n5F3M7NzKqBdheFZvnouZEv8hEqAxQ@mail.gmail.com>
Message-ID: <CAPhsuW5hwAMTy8ozpsT+n5F3M7NzKqBdheFZvnouZEv8hEqAxQ@mail.gmail.com>
Subject: Re: Assemblin journaled array fails
To:     Michal Soltys <msoltyspl@yandex.pl>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000011e0de05a878e43b"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

--00000000000011e0de05a878e43b
Content-Type: text/plain; charset="UTF-8"

On Fri, Jun 19, 2020 at 4:35 AM Michal Soltys <msoltyspl@yandex.pl> wrote:
>
> On 6/17/20 7:11 PM, Song Liu wrote:
> >>
> >>> 1. There are two pr_debug() calls in handle_stripe():
> >>>          pr_debug("handling stripe %llu, state=%#lx cnt=%d, "
> >>>          pr_debug("locked=%d uptodate=%d to_read=%d"
> >>>
> >>>       Did you enable all of them? Or only the first one?
> >>
> >> I enabled all of them (I think), to be precise:
> >>
> >> echo -n 'func handle_stripe +p' >/sys/kernel/debug/dynamic_debug/control
> >>
> >> Haven't seen any `locked` lines though.
> >
> > That's a little weird, and probably explains why we stuck. Could you
> > please try the attached patch?
> >
> > Thanks,
> > Song
> >
>
> I've started assembly with the above patch, the output can be inspected
> from this file:
>
> https://ufile.io/yx4bbcb4
>
> This is ~5mb packed dmesg from start of the boot to the relevant parts,
> unpacks to ~150mb file.

Thanks for the trace. Looks like we may have some issues with
MD_SB_CHANGE_PENDING.
Could you please try the attached patch?

Thanks,
Song

--00000000000011e0de05a878e43b
Content-Type: application/octet-stream; 
	name="0001-debug-MD_SB_CHANGE_PENDING.patch"
Content-Disposition: attachment; 
	filename="0001-debug-MD_SB_CHANGE_PENDING.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kbmw37qh0>
X-Attachment-Id: f_kbmw37qh0

RnJvbSA2YzM3NTg1MjVjNGFiYWRjNjQ4MzljZjE4ZWUzZWQ3YWQ0MDI5M2RhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTb25nIExpdSA8c29uZ2xpdWJyYXZpbmdAZmIuY29tPgpEYXRl
OiBGcmksIDE5IEp1biAyMDIwIDE3OjEyOjA1IC0wNzAwClN1YmplY3Q6IFtQQVRDSF0gZGVidWcg
TURfU0JfQ0hBTkdFX1BFTkRJTkcKCi0tLQogZHJpdmVycy9tZC9tZC5jICAgICAgICAgIHwgMjAg
KysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvbWQvcmFpZDUtY2FjaGUuYyB8ICAxICsKIGRy
aXZlcnMvbWQvcmFpZDUuYyAgICAgICB8ICAyICsrCiAzIGZpbGVzIGNoYW5nZWQsIDIzIGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL21kL21kLmMgYi9kcml2ZXJzL21kL21kLmMK
aW5kZXggZjU2N2Y1MzZiNTI5Yi4uZGJiYzhhNTBlMmVkMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9t
ZC9tZC5jCisrKyBiL2RyaXZlcnMvbWQvbWQuYwpAQCAtMjY3MCw2ICsyNjcwLDggQEAgdm9pZCBt
ZF91cGRhdGVfc2Ioc3RydWN0IG1kZGV2ICptZGRldiwgaW50IGZvcmNlX2NoYW5nZSkKIAkJCWJp
dF9jbGVhcl91bmxlc3MoJm1kZGV2LT5zYl9mbGFncywgQklUKE1EX1NCX0NIQU5HRV9QRU5ESU5H
KSwKIAkJCQkJCQkgQklUKE1EX1NCX0NIQU5HRV9ERVZTKSB8CiAJCQkJCQkJIEJJVChNRF9TQl9D
SEFOR0VfQ0xFQU4pKTsKKwkJCXByX2luZm8oIiVzIGJpdF9jbGVhcl91bmxlc3Mgc2JfZmxhZ3Mg
JWx4XG4iLCBfX2Z1bmNfXywKKwkJCQltZGRldi0+c2JfZmxhZ3MpOwogCQkJcmV0dXJuOwogCQl9
CiAJfQpAQCAtMjY5Nyw2ICsyNjk5LDggQEAgdm9pZCBtZF91cGRhdGVfc2Ioc3RydWN0IG1kZGV2
ICptZGRldiwgaW50IGZvcmNlX2NoYW5nZSkKIAkJY2xlYXJfYml0KE1EX1NCX0NIQU5HRV9ERVZT
LCAmbWRkZXYtPnNiX2ZsYWdzKTsKIAkJaWYgKCFtZGRldi0+ZXh0ZXJuYWwpIHsKIAkJCWNsZWFy
X2JpdChNRF9TQl9DSEFOR0VfUEVORElORywgJm1kZGV2LT5zYl9mbGFncyk7CisJCQlwcl9pbmZv
KCIlcyBjbGVhciBNRF9TQl9DSEFOR0VfUEVORElOR1xuIiwgX19mdW5jX18pOworCiAJCQlyZGV2
X2Zvcl9lYWNoKHJkZXYsIG1kZGV2KSB7CiAJCQkJaWYgKHJkZXYtPmJhZGJsb2Nrcy5jaGFuZ2Vk
KSB7CiAJCQkJCXJkZXYtPmJhZGJsb2Nrcy5jaGFuZ2VkID0gMDsKQEAgLTI4MTUsNiArMjgxOSw5
IEBAIHZvaWQgbWRfdXBkYXRlX3NiKHN0cnVjdCBtZGRldiAqbWRkZXYsIGludCBmb3JjZV9jaGFu
Z2UpCiAJaWYgKG1kZGV2X2lzX2NsdXN0ZXJlZChtZGRldikgJiYgcmV0ID09IDApCiAJCW1kX2Ns
dXN0ZXJfb3BzLT5tZXRhZGF0YV91cGRhdGVfZmluaXNoKG1kZGV2KTsKIAorCWlmIChtZGRldi0+
aW5fc3luYyAhPSBzeW5jX3JlcSkKKwkJcHJfaW5mbygiJXMgYml0X2NsZWFyX3VubGVzcyBzYl9m
bGFncyAlbHhcbiIsIF9fZnVuY19fLAorCQkJbWRkZXYtPnNiX2ZsYWdzKTsKIAlpZiAobWRkZXYt
PmluX3N5bmMgIT0gc3luY19yZXEgfHwKIAkgICAgIWJpdF9jbGVhcl91bmxlc3MoJm1kZGV2LT5z
Yl9mbGFncywgQklUKE1EX1NCX0NIQU5HRV9QRU5ESU5HKSwKIAkJCSAgICAgICBCSVQoTURfU0Jf
Q0hBTkdFX0RFVlMpIHwgQklUKE1EX1NCX0NIQU5HRV9DTEVBTikpKQpAQCAtNDM4OSw2ICs0Mzk2
LDggQEAgYXJyYXlfc3RhdGVfc3RvcmUoc3RydWN0IG1kZGV2ICptZGRldiwgY29uc3QgY2hhciAq
YnVmLCBzaXplX3QgbGVuKQogCQlpZiAoc3QgPT0gYWN0aXZlKSB7CiAJCQlyZXN0YXJ0X2FycmF5
KG1kZGV2KTsKIAkJCWNsZWFyX2JpdChNRF9TQl9DSEFOR0VfUEVORElORywgJm1kZGV2LT5zYl9m
bGFncyk7CisJCQlwcl9pbmZvKCIlcyBjbGVhciBNRF9TQl9DSEFOR0VfUEVORElOR1xuIiwgX19m
dW5jX18pOworCiAJCQltZF93YWtldXBfdGhyZWFkKG1kZGV2LT50aHJlYWQpOwogCQkJd2FrZV91
cCgmbWRkZXYtPnNiX3dhaXQpOwogCQl9IGVsc2UgLyogc3QgPT0gY2xlYW4gKi8gewpAQCAtNDQ2
Myw2ICs0NDcyLDggQEAgYXJyYXlfc3RhdGVfc3RvcmUoc3RydWN0IG1kZGV2ICptZGRldiwgY29u
c3QgY2hhciAqYnVmLCBzaXplX3QgbGVuKQogCQkJaWYgKGVycikKIAkJCQlicmVhazsKIAkJCWNs
ZWFyX2JpdChNRF9TQl9DSEFOR0VfUEVORElORywgJm1kZGV2LT5zYl9mbGFncyk7CisJCQlwcl9p
bmZvKCIlcyBjbGVhciBNRF9TQl9DSEFOR0VfUEVORElOR1xuIiwgX19mdW5jX18pOworCiAJCQl3
YWtlX3VwKCZtZGRldi0+c2Jfd2FpdCk7CiAJCQllcnIgPSAwOwogCQl9IGVsc2UgewpAQCAtODQ2
OSw2ICs4NDgwLDcgQEAgYm9vbCBtZF93cml0ZV9zdGFydChzdHJ1Y3QgbWRkZXYgKm1kZGV2LCBz
dHJ1Y3QgYmlvICpiaSkKIAkJCW1kZGV2LT5pbl9zeW5jID0gMDsKIAkJCXNldF9iaXQoTURfU0Jf
Q0hBTkdFX0NMRUFOLCAmbWRkZXYtPnNiX2ZsYWdzKTsKIAkJCXNldF9iaXQoTURfU0JfQ0hBTkdF
X1BFTkRJTkcsICZtZGRldi0+c2JfZmxhZ3MpOworCQkJcHJfaW5mbygiJXMgc2V0IE1EX1NCX0NI
QU5HRV9QRU5ESU5HXG4iLCBfX2Z1bmNfXyk7CiAJCQltZF93YWtldXBfdGhyZWFkKG1kZGV2LT50
aHJlYWQpOwogCQkJZGlkX2NoYW5nZSA9IDE7CiAJCX0KQEAgLTg1NDQsNiArODU1Niw4IEBAIHZv
aWQgbWRfYWxsb3dfd3JpdGUoc3RydWN0IG1kZGV2ICptZGRldikKIAkJbWRkZXYtPmluX3N5bmMg
PSAwOwogCQlzZXRfYml0KE1EX1NCX0NIQU5HRV9DTEVBTiwgJm1kZGV2LT5zYl9mbGFncyk7CiAJ
CXNldF9iaXQoTURfU0JfQ0hBTkdFX1BFTkRJTkcsICZtZGRldi0+c2JfZmxhZ3MpOworCQlwcl9p
bmZvKCIlcyBzZXQgTURfU0JfQ0hBTkdFX1BFTkRJTkdcbiIsIF9fZnVuY19fKTsKKwogCQlpZiAo
bWRkZXYtPnNhZmVtb2RlX2RlbGF5ICYmCiAJCSAgICBtZGRldi0+c2FmZW1vZGUgPT0gMCkKIAkJ
CW1kZGV2LT5zYWZlbW9kZSA9IDE7CkBAIC04OTQ4LDYgKzg5NjIsOCBAQCB2b2lkIG1kX2RvX3N5
bmMoc3RydWN0IG1kX3RocmVhZCAqdGhyZWFkKQogCXNldF9tYXNrX2JpdHMoJm1kZGV2LT5zYl9m
bGFncywgMCwKIAkJICAgICAgQklUKE1EX1NCX0NIQU5HRV9QRU5ESU5HKSB8IEJJVChNRF9TQl9D
SEFOR0VfREVWUykpOwogCisJcHJfaW5mbygiJXMgc2V0IE1EX1NCX0NIQU5HRV9QRU5ESU5HXG4i
LCBfX2Z1bmNfXyk7CisKIAlpZiAodGVzdF9iaXQoTURfUkVDT1ZFUllfUkVTSEFQRSwgJm1kZGV2
LT5yZWNvdmVyeSkgJiYKIAkJCSF0ZXN0X2JpdChNRF9SRUNPVkVSWV9JTlRSLCAmbWRkZXYtPnJl
Y292ZXJ5KSAmJgogCQkJbWRkZXYtPmRlbHRhX2Rpc2tzID4gMCAmJgpAQCAtOTE5Nyw2ICs5MjEz
LDggQEAgdm9pZCBtZF9jaGVja19yZWNvdmVyeShzdHJ1Y3QgbWRkZXYgKm1kZGV2KQogCQkJY2xl
YXJfYml0KE1EX1JFQ09WRVJZX1JFQ09WRVIsICZtZGRldi0+cmVjb3ZlcnkpOwogCQkJY2xlYXJf
Yml0KE1EX1JFQ09WRVJZX05FRURFRCwgJm1kZGV2LT5yZWNvdmVyeSk7CiAJCQljbGVhcl9iaXQo
TURfU0JfQ0hBTkdFX1BFTkRJTkcsICZtZGRldi0+c2JfZmxhZ3MpOworCQkJcHJfaW5mbygiJXMg
Y2xlYXIgTURfU0JfQ0hBTkdFX1BFTkRJTkdcbiIsIF9fZnVuY19fKTsKKwogCQkJZ290byB1bmxv
Y2s7CiAJCX0KIApAQCAtOTQxMSw2ICs5NDI5LDggQEAgaW50IHJkZXZfc2V0X2JhZGJsb2Nrcyhz
dHJ1Y3QgbWRfcmRldiAqcmRldiwgc2VjdG9yX3QgcywgaW50IHNlY3RvcnMsCiAJCXN5c2ZzX25v
dGlmeV9kaXJlbnRfc2FmZShyZGV2LT5zeXNmc19zdGF0ZSk7CiAJCXNldF9tYXNrX2JpdHMoJm1k
ZGV2LT5zYl9mbGFncywgMCwKIAkJCSAgICAgIEJJVChNRF9TQl9DSEFOR0VfQ0xFQU4pIHwgQklU
KE1EX1NCX0NIQU5HRV9QRU5ESU5HKSk7CisJCXByX2luZm8oIiVzIHNldCBNRF9TQl9DSEFOR0Vf
UEVORElOR1xuIiwgX19mdW5jX18pOworCiAJCW1kX3dha2V1cF90aHJlYWQocmRldi0+bWRkZXYt
PnRocmVhZCk7CiAJCXJldHVybiAxOwogCX0gZWxzZQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZC9y
YWlkNS1jYWNoZS5jIGIvZHJpdmVycy9tZC9yYWlkNS1jYWNoZS5jCmluZGV4IDliNmRhNzU5ZGNh
MjUuLjYwZmEwOGYwMTcwYmMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbWQvcmFpZDUtY2FjaGUuYwor
KysgYi9kcml2ZXJzL21kL3JhaWQ1LWNhY2hlLmMKQEAgLTEzMzcsNiArMTMzNyw3IEBAIHN0YXRp
YyB2b2lkIHI1bF93cml0ZV9zdXBlcl9hbmRfZGlzY2FyZF9zcGFjZShzdHJ1Y3QgcjVsX2xvZyAq
bG9nLAogCSAqLwogCXNldF9tYXNrX2JpdHMoJm1kZGV2LT5zYl9mbGFncywgMCwKIAkJQklUKE1E
X1NCX0NIQU5HRV9ERVZTKSB8IEJJVChNRF9TQl9DSEFOR0VfUEVORElORykpOworCXByX2luZm8o
IiVzIHNldCBNRF9TQl9DSEFOR0VfUEVORElOR1xuIiwgX19mdW5jX18pOwogCWlmICghbWRkZXZf
dHJ5bG9jayhtZGRldikpCiAJCXJldHVybjsKIAltZF91cGRhdGVfc2IobWRkZXYsIDEpOwpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9tZC9yYWlkNS5jIGIvZHJpdmVycy9tZC9yYWlkNS5jCmluZGV4IGNh
NzQ3NmZhYzNlOWQuLjMyNDBkZWUxZGE3YmYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbWQvcmFpZDUu
YworKysgYi9kcml2ZXJzL21kL3JhaWQ1LmMKQEAgLTI3MDQsNiArMjcwNCw4IEBAIHN0YXRpYyB2
b2lkIHJhaWQ1X2Vycm9yKHN0cnVjdCBtZGRldiAqbWRkZXYsIHN0cnVjdCBtZF9yZGV2ICpyZGV2
KQogCXNldF9iaXQoQmxvY2tlZCwgJnJkZXYtPmZsYWdzKTsKIAlzZXRfbWFza19iaXRzKCZtZGRl
di0+c2JfZmxhZ3MsIDAsCiAJCSAgICAgIEJJVChNRF9TQl9DSEFOR0VfREVWUykgfCBCSVQoTURf
U0JfQ0hBTkdFX1BFTkRJTkcpKTsKKwlwcl9pbmZvKCIlcyBzZXQgTURfU0JfQ0hBTkdFX1BFTkRJ
TkdcbiIsIF9fZnVuY19fKTsKKwogCXByX2NyaXQoIm1kL3JhaWQ6JXM6IERpc2sgZmFpbHVyZSBv
biAlcywgZGlzYWJsaW5nIGRldmljZS5cbiIKIAkJIm1kL3JhaWQ6JXM6IE9wZXJhdGlvbiBjb250
aW51aW5nIG9uICVkIGRldmljZXMuXG4iLAogCQltZG5hbWUobWRkZXYpLAotLSAKMi4yNC4xCgo=
--00000000000011e0de05a878e43b--
