Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDB8011EF74
	for <lists+linux-raid@lfdr.de>; Sat, 14 Dec 2019 02:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfLNBOK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 13 Dec 2019 20:14:10 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:36710 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfLNBOK (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 13 Dec 2019 20:14:10 -0500
Received: by mail-ed1-f42.google.com with SMTP id j17so625667edp.3
        for <linux-raid@vger.kernel.org>; Fri, 13 Dec 2019 17:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=lCEr7FmW1dTokLbPjZGqOU0wQHevq9/0MxfTZ9hCZLY=;
        b=p+/AlNfhv6kR2JkmgXTpWatBaWHFeMRqPJIwrE7KbLraVAUReBwn/hRGBBtOoPrhwO
         +XtDuTOsfvV81oeFFcZZYjwUJBxXdqJcA+Hh3ML4tlCGmiFLsni6m2+vb/+aNl2W/bS/
         RyxTIFZQ0o5EQ0qUCjCLiuzT1qDKo/Hey/H2RDC1snyjhLj4oUY+pWQkncBfBb254ScP
         Ms1t3sus2nFcEVnz56MXU/aj7orPSxVW1d/FG0eYw8j+KIkVdOBHF6KyXZHuwivd7FFB
         MJh7Eu7/b/QWTJv4A6DGp/Zfa2ZPKenRQRzPAidUwrNmZEw9RBFzSfEGVRhLQktKVeXN
         8ZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=lCEr7FmW1dTokLbPjZGqOU0wQHevq9/0MxfTZ9hCZLY=;
        b=KlzOzVf3onLNySqZOtqVnDJNQN8+1oWwL2U1vCsb44Ht+09/vvRDbIGb43Zyf/1b/k
         mDN/gYflc13OYNBIAEranYyom3PjUrQPYOZP4T2I1OnOzWQRSknkYv2DPxythQ3B7XBg
         VvdACuiKfqzMI2xQdHqBRO9u94eOO2vR+eogXqd4wQ9IrMSstdhjULV3AsFgbqmMPxxi
         PyRFbbU/S8yubVriIYn6jo3fjkiIGIRQMJzVJMow99bhupm5bLRDQQi/YiV/SBOzOV14
         akuah67LquskW/OJ6gWCZ8R+JWJixZQc1JonMUd8j9rZTcD07u4gWwsPH25QUIoDBWoZ
         rVmQ==
X-Gm-Message-State: APjAAAXGDzpGQE/EpJkcz/bNSuChbCrJbATCFaonN+EAikiNKRjW4RVO
        UfEqPb+aXq1wzztHOCgrqaGddUdgga/pIGZLMZzGQA==
X-Google-Smtp-Source: APXvYqzjrT0+cJYPhRrcqH2OzFv7/hqSeD+GLZcTygNrWfVzhCA/zZsB1LAUUyL2M3OUFCv7XhSCjx9YK0eka5UghE8=
X-Received: by 2002:a05:6402:2051:: with SMTP id bc17mr19368437edb.28.1576286048733;
 Fri, 13 Dec 2019 17:14:08 -0800 (PST)
MIME-Version: 1.0
From:   "David F." <df7729@gmail.com>
Date:   Fri, 13 Dec 2019 17:13:57 -0800
Message-ID: <CAGRSmLsh0aqJMuFzMMhm6fYjsCL-MNXR=t04cGj9FNvG0EENTQ@mail.gmail.com>
Subject: Why isn't the "Support Intel AHCI remapped NVMe devices" in mainline?
To:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

Despite not liking what Intel did, there isn't any reason Linux
shouldn't support these devices in RAID mode..   The main support
issues with our Linux based product is now this problem with no hard
drives listed in Linux.   Get a couple everyday.  Some people can't
change to AHCI mode, such as some Lenovo machines.

If the patch simply adds support for this mode without affecting
anything when not in that mode then why wouldn't you mainline it?
This problem is widespread.

TIA!
