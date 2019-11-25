Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5C30108ED3
	for <lists+linux-raid@lfdr.de>; Mon, 25 Nov 2019 14:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfKYNZK (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 25 Nov 2019 08:25:10 -0500
Received: from mail.fsf.org ([209.51.188.13]:53857 "EHLO mail.fsf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727662AbfKYNZK (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 25 Nov 2019 08:25:10 -0500
X-Greylist: delayed 2746 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Nov 2019 08:25:10 EST
Received: from mail.iankelling.org ([72.14.176.105]:52450)
        by mail.fsf.org with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.69)
        (envelope-from <iank@fsf.org>)
        id 1iZDeF-00086a-K9
        for linux-raid@vger.kernel.org; Mon, 25 Nov 2019 07:39:23 -0500
Received: from iank by mail.iankelling.org with local (Exim 4.90_1)
        (envelope-from <iank@fsf.org>)
        id 1iZ6RJ-0004E4-4a; Sun, 24 Nov 2019 23:57:33 -0500
References: <3fc5f3df-0589-645c-f36a-2eee83e8bccd () gnu ! org>
 <3fc5f3df-0589-645c-f36a-2eee83e8bccd@gnu.org>
 <877e3ozt9r.fsf@iankelling.org>
User-agent: mu4e 1.1.0; emacs 27.0.50
From:   Ian Kelling <iank@fsf.org>
To:     Ian Kelling <ian@iankelling.org>
Cc:     linux-raid@vger.kernel.org
Subject: Re: Deep into potential data loss issue
In-reply-to: <877e3ozt9r.fsf@iankelling.org>
Date:   Sun, 24 Nov 2019 23:57:33 -0500
Message-ID: <871rtw5z9e.fsf@fsf.org>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by mail.fsf.org: GNU/Linux 2.2.x-3.x [generic] [fuzzy]
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Update: we dd'ed the 3 partitions into copies, used those to --create
the array without fearing data loss, which seems to have worked. As I
type, dd is in progress from the recreated degraded raid10 array over to
a new raid1 partition.

